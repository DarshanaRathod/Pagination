//
//  PageDemoVC.swift
//  paginationDemo
//
//  Created by Stegowl05 on 15/03/19.
//  Copyright © 2019 Stegowl. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import PagingTableView

class tblPage: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
}

class PageDemoVC: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var tblPageView: PagingTableView!
    //@IBOutlet weak var tblPage: UITableView!
    var arrPage = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblPageView.pagingDelegate = self
        tblPageView.delegate = self
        tblPageView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tblPage", for: indexPath)as! tblPage
        cell.lblName.text = (arrPage.object(at: indexPath.row)as AnyObject).value(forKey: "song_name")as? String
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
//    func paginate(_ tableView: PagingTableView, to page: Int) {
//        tblPageView.isLoading = true
//        WBPage(page)
//    }
    
    func WBPage(_ page : Int){
        let strURL = "http://durisimomobileapps.net/flowactivo/api/allsongs?page=\(page+1)"
        let Para = ["user_id":"769"]
        print(strURL)
        print(Para)
        Alamofire.request(strURL, method: .post, parameters: Para, encoding: JSONEncoding.default, headers: nil).responseJSON { (responseObject) -> Void in
            print(responseObject)
            if (responseObject.result.value != nil){
                let response = responseObject.result.value as! NSDictionary
                let status = response["status"] as! NSNumber
                if status != 0{
                    let data = response["data"] as! NSArray
                    let arrData = data.mutableCopy() as! NSMutableArray
                    for i in 0..<arrData.count{
                       self.arrPage.add(arrData.object(at: i)as AnyObject)
                        if i == arrData.count-1{
                            self.tblPageView.reloadData()
                             self.tblPageView.isLoading = false
                        }
                    }
                }else{
                    print("NO Data")
                }
            }else{
                
            }
        }
    }
}
extension PageDemoVC: PagingTableViewDelegate {
    
    func paginate(_ tableView: PagingTableView, to page: Int) {
        tblPageView.isLoading = true
        WBPage(page)
        }
    }
