//
//  PlatsViewController.swift
//  VartSkaManGo
//
//  Created by Shamo Zahidov on 2020-03-15.
//  Copyright © 2020 Shamo Zahidov. All rights reserved.
//

import Foundation
class Platser {
    
    var plats_id:String?
    var plats_name:String?
    var plats_city:String?
    var plats_Adress:String?
    var plats_photo:String?
    var plats_text:String?
    var kategori_name:String?
   
    
    
    init() {
        
    }
    
    init(plats_id:String, plats_name:String ,plats_city:String,plats_Adress:String,plats_photo:String,plats_text:String, kategori_name:String){
        
        self.plats_id = plats_id
        self.plats_name = plats_name
        self.plats_city = plats_city
        self.plats_Adress = plats_Adress
        self.plats_photo = plats_photo
        self.plats_text = plats_text
        self.kategori_name = kategori_name
        
    }
}
