//
//  ViewController.swift
//  NetworkModule
//
//  Created by 육승현 on 2021/10/14.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var apiTestTableView: UITableView!
    @IBOutlet weak var displayLabel: UILabel!
    
    private var apis: Array<ApiListData>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setData()
        
        apiTestTableView.delegate = self
        apiTestTableView.dataSource = self
        
        apiTestTableView.register(UINib(nibName: "ApiTableViewCell", bundle: nil), forCellReuseIdentifier: "ApiTableViewCell")
        
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apis?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ApiTableViewCell", for: indexPath) as! ApiTableViewCell
        
        cell.setData(data: apis?[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let apiRequest = APIs.allCases[indexPath.row]
        
        switch apiRequest.name {
        case "session":
            APIRequest.session() { result in
                switch result {
                case .success(let sessionResult):
                    if sessionResult.header?.code == ServerCode.success.rawValue {
                        self.apis?[indexPath.row].isSuccess = true
                        self.displayLabel.text = sessionResult.sessionBody?.encKey
                    } else {
                        self.apis?[indexPath.row].isSuccess = false
                    }
                case .failure(_ ):
                    self.apis?[indexPath.row].isSuccess = false
                }
                self.apiTestTableView.reloadData()
            }
        case "login":
                APIRequest.login(id: "id", password: "pass") { result in
                    switch result {
                    case .success(let loginResult):
                        if loginResult.header?.code == ServerCode.success.rawValue {
                            self.apis?[indexPath.row].isSuccess = true
                        } else {
                            self.apis?[indexPath.row].isSuccess = false
                        }
                    case .failure(_ ):
                        self.apis?[indexPath.row].isSuccess = false
                    }
                    self.apiTestTableView.reloadData()
                }
        default:
            break
        }
        
    }
    
    // MARK: - Data Setting
    private func setData() {
        apis = Array<ApiListData>()
        for api in APIs.allCases {
            let testData = ApiListData()
            testData.apiImgUrl = "api icon image"
            testData.apiDescription = api.name
            testData.isSuccess = nil
            apis?.append(testData)
        }
        apiTestTableView.reloadData()
    }
}

