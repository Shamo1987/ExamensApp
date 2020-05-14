//
//  Kategorier.swift
//  VartSkaManGo
//
//  Created by Shamo Zahidov on 2020-03-15.
//  Copyright © 2020 Shamo Zahidov. All rights reserved.
//

import Foundation

class Kategorier {
    
    var kategori_id:String?
    var kategori_name:String?
    
    init() {
        
    }
    
    init(kategori_id:String,kategori_name:String) {
        
        self.kategori_id = kategori_id
        self.kategori_name = kategori_name
        
    }
}
