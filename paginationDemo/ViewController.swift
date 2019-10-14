//
//  ViewController.swift
//  paginationDemo
//
//  Created by Stegowl05 on 11/03/19.
//  Copyright © 2019 Stegowl. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON
import PagingTableView

class tblCell: UITableViewCell{
    @IBOutlet weak var lblName: UILabel!
}
class collCell: UICollectionViewCell{
    @IBOutlet weak var imgData: UIImageView!
}

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collData: UICollectionView!
    @IBOutlet weak var tblData: PagingTableView!
  
    var arrData = NSMutableArray()
    var arrtblData = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblData.dataSource = self
        tblData.pagingDelegate = self as PagingTableViewDelegate
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collData.collectionViewLayout = layout
        WBColl()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrtblData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tblCell", for: indexPath)as! tblCell
        cell.lblName.text = (arrtblData.object(at: indexPath.row) as AnyObject).value(forKey: "song_name")as? String
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.size.width/2 ,height: 200)//, height: collectionView.frame.size.height/2)
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collCell", for: indexPath)as! collCell
        cell.imgData.sd_setImage(with: NSURL(string: (arrData.object(at: indexPath.row)as AnyObject).value(forKey: "song_image") as! String)! as URL, placeholderImage: UIImage(named:""))
        return cell
    }

    func WBtbl(_ page: Int){
        //var curruntpage = 1
        let strURL = "http://durisimomobileapps.net/flowactivo/api/allsongs?page=\(page+1)"
        let parameter = ["user_id":"769"]
        print(strURL)
        print(parameter)
        Alamofire.request(strURL, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (responseObject) -> Void in
            print(responseObject)
            if (responseObject.result.value != nil)
            {
                let result = responseObject.result.value as! NSDictionary
                print(result)
               
                let status = result["status"] as! NSNumber
                if  status != 0{
                    let data = result["data"] as! NSArray
                    let arrSong = data.mutableCopy() as! NSMutableArray
                    for i in 0..<arrSong.count{
                        self.arrtblData.add(arrSong.object(at: i) as AnyObject)
                        if i == arrSong.count - 1 {
                            self.tblData.reloadData()
                            self.tblData.isLoading = false
                        }
                    }
                }
            }else{
                
            }
        }
    }
    func WBColl(){
        let strURL = "http://durisimomobileapps.net/flowactivo/api/featuredsongs"
        let parameter = ["user_id":"769"]
        print(parameter)
        Alamofire.request(strURL, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseJSON{ Response in
            print(Response)
            if (Response.result.value != nil)
            {
                
                let result = Response.result.value as! NSDictionary
                print(result)
                let status = result["status"] as! NSNumber
                if  status != 0{
                    let data = result["data"] as! NSArray
                   self.arrData = data.mutableCopy() as! NSMutableArray
                    self.collData.reloadData()
                }
            }else{
                
            }
        }
    }
}
extension ViewController: PagingTableViewDelegate {
    
    func paginate(_ tableView: PagingTableView, to page: Int) {
       
        tblData.isLoading = true

         self.WBtbl(page)
        //self.arrtblData(contentsOf: Pageno)
       // self.tblData.isLoading = false
    }
}
