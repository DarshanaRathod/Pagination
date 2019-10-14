//
//  TokanVC.swift
//  paginationDemo
//
//  Created by Stegowl05 on 14/03/19.
//  Copyright © 2019 Stegowl. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TokanVC: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myView = UIView()
        myView.backgroundColor = UIColor.red
        self.view.addSubview(myView)
        myView.translatesAutoresizingMaskIntoConstraints = false
      //  view.addConstraint(NSLayoutConstraint(item: myView, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: myView, attribute: .bottom, relatedBy: .equal, toItem: self.bottomLayoutGuide, attribute:.top, multiplier: 1, constant: 50))
        view.addConstraint(NSLayoutConstraint(item: myView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 100))
        view.addConstraint(NSLayoutConstraint(item: myView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 100))
        // view.addConstraint(NSLayoutConstraint(item: myView, attribute: .leadingMargin, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1, constant: 20))
        view.addConstraint(NSLayoutConstraint(item: myView, attribute: .trailingMargin, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1, constant: 20))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

    @IBAction func btnSignIn(_ sender: UIButton) {
        WBLogIn()
    }
    func WBLogIn(){
       
        let strURL = "http://durisimomobileapps.net/sprinkler/api/login"
        let parameter = [ "email":"testingmobileappsforyou@gmail.com",
                            "password":"123",
                            "fcm_id":"fUYpptD4R-Q:APA91bFWUKv99lkjBvDvfbAY1nCV_gNg0_sqfo_8gHEELoET6YfzilInecg35e4XOMP3yzgeXrbIlI3PHjbyUIeYMxIwEDcivY6fWt-9dOgG1R_dsPsKV6KYXrIZ9wpdx-WYtX79PRnhfhdY4g27zAs3HpNZNPhfEg",
                            "role":3] as [String : Any]
        
        let headers = ["token":"JBjgvbkgjbKJGB245jbk434KJ5N089"]
        print(strURL)
        print(parameter)
        print(headers)
        Alamofire.request(strURL, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            if (responseObject.result.value != nil)
            {
                let result = responseObject.result.value as! NSDictionary
                print(result)
                let status = result["status"] as! NSNumber
                if  status != 0{
                    
                }
            }else{
                
            }
        }
    }
}
