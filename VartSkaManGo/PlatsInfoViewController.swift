//
//  PlatsInfoViewController.swift
//  VartSkaManGo
//
//  Created by Shamo Zahidov on 2020-03-15.
//  Copyright © 2020 Shamo Zahidov. All rights reserved.
//

import UIKit

class PlatsInfoViewController: UIViewController {

    @IBOutlet weak var imageViewPlatsBild: UIImageView!
    
    @IBOutlet weak var labelPlatsAdress: UILabel!
   
    @IBOutlet weak var labelPlatsDetail: UITextView!
    
    var plats:Platser?
    override func viewDidLoad() {
        super.viewDidLoad()

        if let p = plats{
             if let url = URL(string: "http://shamozahidov.tech/placeImage/\(p.plats_photo!).jpg"){
                       
                       DispatchQueue.global().async {
                           let data = try? Data(contentsOf: url)
                           DispatchQueue.main.async {
                               self.imageViewPlatsBild.image = UIImage(data: data!)
                           }
                       }
                   }
            
            labelPlatsAdress.text = p.plats_Adress
            labelPlatsDetail.text = p.plats_text
            
            
            
        }
    }
    

    

}
