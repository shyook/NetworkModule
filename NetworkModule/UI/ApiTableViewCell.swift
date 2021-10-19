//
//  ApiTableViewCell.swift
//  NetworkModule
//
//  Created by 육승현 on 2021/10/20.
//

import UIKit

class ApiTableViewCell: UITableViewCell {

    @IBOutlet weak var apiImgUrl: UIImageView!
    @IBOutlet weak var apiName: UILabel!
    @IBOutlet weak var apiTestResult: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data: ApiListData?) {
        if let data = data {
            if let url = data.apiImgUrl {
                apiImgUrl.image = UIImage(named: url)
            } else {
                apiImgUrl.image = nil
            }
            
            apiName.text = data.apiDescription
            apiTestResult.text = "실패"
            if let success = data.isSuccess, success {
                apiTestResult.text = "성공"
            }
        }
    }
    
}
