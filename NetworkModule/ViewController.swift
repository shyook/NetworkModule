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
    
    // MARK: - Data Setting
    private func setData() {
        apis = Array<ApiListData>()
        for api in APIs.allCases {
            let testData = ApiListData()
            testData.apiImgUrl = "api icon image"
            testData.apiDescription = api.name
            testData.isSuccess = true
            apis?.append(testData)
        }
        apiTestTableView.reloadData()
    }
}

