//
//  ViewController.swift
//  APIManager
//
//  Created by Guru Technolabs on 12/01/17.
//  Copyright © 2017 GuruTechnolabs. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // service call
        self.getData()
        
    }
   
    
    func getData(){
        let parameter = "mobile_no=9624341608&password=123456"
        
        APIManager.sharedInstance.ServiceCall(method:"post",parameter:parameter, completion:{(result,error) -> Void in
            if (result != nil){
                print(result!)
            }
            else{
                print(error!)
            }
        })
    }
    
}

