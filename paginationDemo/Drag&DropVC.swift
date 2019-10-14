//
//  Drag&DropVC.swift
//  paginationDemo
//
//  Created by Stegowl05 on 15/03/19.
//  Copyright © 2019 Stegowl. All rights reserved.
//

import UIKit
class tblDropDownCell: UITableViewCell{
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var viewDropDown: UIView!
    @IBOutlet weak var img: UIImageView!
}

class Drag_DropVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIDropInteractionDelegate {

    @IBOutlet weak var tblData: UITableView!
    @IBOutlet weak var btnEdit: UIButton!
    
    var arrData = ["ABC","DEF","GHI","JKL","MNO","PQR","STU","VWX","YZW"]
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.tblData.isEditing = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tblDropDownCell", for: indexPath)as! tblDropDownCell
        cell.lblName.text = arrData[indexPath.row]
       // cell.contentView.superview?.backgroundColor = UIColor.clear
        let imageName = "download"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
       // imageView.frame = CGRect(x: 265, y: 15, width: 100, height: 45)
        imageView.frame = CGRect(x: 265, y: 0, width: 100, height: 45)
        cell.contentView.addSubview(imageView)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    @IBAction func btnEditClick(_ sender: UIButton) {
        tblData.isEditing = !tblData.isEditing
        tblData.reloadData()
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if (editingStyle == .none) {
//            toDoList.remove(at: indexPath.row)
//
//            UserDefaults.standard.set(toDoList, forKey: "toDoList")
//            tableView.reloadData()
//        }
//    }
     func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

   func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
            return true;
    }
   func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let dropInteraction = UIDropInteraction(delegate: self)
        let imageName = "download"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.addInteraction(dropInteraction)
        let itemToMove = arrData[sourceIndexPath.row]
        arrData.remove(at: sourceIndexPath.row)
        arrData.insert(itemToMove, at: destinationIndexPath.row)
    }
}
