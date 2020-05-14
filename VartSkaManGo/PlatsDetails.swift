
//
//  PlatsViewController.swift
//  VartSkaManGo
//
//  Created by Shamo Zahidov on 2020-03-15.
//  Copyright © 2020 Shamo Zahidov. All rights reserved.
//
import Foundation
class Platsdetails {
    
    var platsdetail_id:Int?
    var platsdetail_text:String?
    
    init() {
        
    }
    
    init(platsdetail_id:Int,platsdetail_text:String) {
        
        self.platsdetail_id = platsdetail_id
        self.platsdetail_text = platsdetail_text
        
    }
}
