
//
//  PaginationVC.swift
//  paginationDemo
//
//  Created by Stegowl05 on 12/03/19.
//  Copyright © 2019 Stegowl. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON

class pageCell: UITableViewCell{
    
    @IBOutlet weak var lblName: UILabel!
}
class PaginationVC: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tblPage: UITableView!
    var arr:[Int] = Array()
    var limit = 20
    let total = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()

        WBtbl(1)
        tblPage.tableFooterView = UIView(frame: .zero)
        var index = 0
        while index < limit {
            arr.append(index)
            index = index + 1
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "pageCell", for: indexPath)as! pageCell
            cell.lblName.text = "Row \(arr[indexPath.row])"
            return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == arr.count - 1{
            if arr.count < total
            {
                var index = arr.count
                limit = index + 20
                while index < limit {
                    arr.append(index)
                    index = index + 1
                }
                self.perform(#selector(loadtable), with: nil, afterDelay: 1.0)
            }
        }
        
    }
    @objc func loadtable(){
        self.tblPage.reloadData()
    }
    func WBtbl(_ page: Int){
        //var curruntpage = 1
        let strURL = "http://durisimomobileapps.net/flowactivo/api/allsongs?page=\(page) "
        let parameter = ["user_id":"769"]
        print(strURL)
        print(parameter)
        Alamofire.request(strURL, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (responseObject) -> Void in
            if (responseObject.result.value != nil)
            {
                let result = responseObject.result.value as! NSDictionary
                print(result)
                let status = result["status"] as! NSNumber
                if  status != 0{
                    let data = result["data"] as! NSArray
                    self.arr = (data.mutableCopy() as! NSMutableArray) as! [Int]
                    self.tblPage.reloadData()
                }
            }else{
                
            }
        }
    }
}
