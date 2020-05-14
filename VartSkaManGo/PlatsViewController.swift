//
//  PlatsViewController.swift
//  VartSkaManGo
//
//  Created by Shamo Zahidov on 2020-03-15.
//  Copyright © 2020 Shamo Zahidov. All rights reserved.
//

import UIKit
import Firebase
class PlatsViewController: UIViewController {

    @IBOutlet weak var platsCollectionView: UICollectionView!
    
    var platsList = [Platser]()
    var kategori : Kategorier?
    var ref:DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()

  
        
        platsCollectionView.delegate = self
        platsCollectionView.dataSource = self
       
        //CELL SIZE
        let design:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let bredd = self.platsCollectionView.frame.size.width
        
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let cellBredd = (bredd-30)/2
        
        design.itemSize = CGSize(width: cellBredd, height: cellBredd*1.75)
        
        design.minimumInteritemSpacing = 10
        design.minimumLineSpacing = 10
        
        platsCollectionView.collectionViewLayout = design
        
        ref = Database.database().reference()
        
        if let k = kategori{
            navigationItem.title = k.kategori_name
            platserByKategoriName(kategori_name:k.kategori_name!)
            
        }
        
    }
    func platserByKategoriName(kategori_name:String){
        let question = ref.child("Platser").queryOrdered(byChild: "kategori_name").queryEqual(toValue: kategori_name)
        
        
         question.observe(.value, with: {snapshot in
             if let inkommandeData = snapshot.value as? [String:AnyObject]{
                 
                 self.platsList.removeAll()
                 for inkommandeRadData in inkommandeData{
                     if let lexikon = inkommandeRadData.value as? NSDictionary{
                         let key = inkommandeRadData.key
                         let plats_name = lexikon["plats_name"] as? String ?? ""
                         let plats_city = lexikon["plats_city"] as? String ?? ""
                         let plats_Adress = lexikon["plats_Adress"] as? String ?? ""
                         let plats_photo = lexikon["plats_photo"] as? String ?? ""
                         let kategori_name = lexikon["kategori_name"] as? String ?? ""
                         let plats_text = lexikon["plats_text"] as? String ?? ""
                        
                         
                        let plats = Platser(plats_id: key, plats_name: plats_name, plats_city: plats_city, plats_Adress: plats_Adress, plats_photo: plats_photo, plats_text: plats_text, kategori_name: kategori_name)
                        
                        self.platsList.append(plats)
                         
                     }
                     
                 }
             }
             
             DispatchQueue.main.async {
                self.platsCollectionView.reloadData()
             }
             
         })
         
     }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        
        let togoVC = segue.destination as!  PlatsInfoViewController
            togoVC.plats = platsList[indeks!]
        
        
    }

}
extension PlatsViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return platsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let plats = platsList[indexPath.row]
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "platsCell", for: indexPath) as! PlatsCellCollectionViewCell
        
        cell.labelPlatsName.text = plats.plats_name
        cell.labelStad.text = plats.plats_city
        
        //Load photo
        if let url = URL(string: "http://shamozahidov.tech/placeImage/\(plats.plats_photo!).jpg"){
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    cell.imageViewPlatsBild.image = UIImage(data: data!)
                }
            }
        }
        
        //Cell line
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: indexPath.row)
    }
    
    
}


