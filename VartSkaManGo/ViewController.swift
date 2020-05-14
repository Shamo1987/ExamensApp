//
//  ViewController.swift
//  VartSkaManGo
//
//  Created by Shamo Zahidov on 2020-03-14.
//  Copyright © 2020 Shamo Zahidov. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var kategoriTableView: UITableView!
    
    var kategoriList = [Kategorier]()
    var ref:DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kategoriTableView.delegate = self
        kategoriTableView.dataSource = self
        
        ref = Database.database().reference()
      
        
        GetAllKategorier()
    }
    func GetAllKategorier(){
        ref.child("Kategorier").observe(.value, with: {snapshot in
            if let inkommandeData = snapshot.value as? [String:AnyObject]{
                
                self.kategoriList.removeAll()
                for inkommandeRadData in inkommandeData{
                    if let lexikon = inkommandeRadData.value as? NSDictionary{
                        let key = inkommandeRadData.key
                        let kategori_name = lexikon["kategori_name"] as? String ?? ""
                      
                        let kategori = Kategorier(kategori_id: key, kategori_name: kategori_name)
                        
                        self.kategoriList.append(kategori)
                        
                    }
                    
                }
            }
            
            DispatchQueue.main.async {
                self.kategoriTableView.reloadData()
            }
            
            
            
            
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        
        let togoVC = segue.destination as!  PlatsViewController
        togoVC.kategori = kategoriList[indeks!]
        
        
    }
    

}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return kategoriList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let kategori = kategoriList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "kategoriCell", for: indexPath) as! KategoriCellTableViewCell
        
        cell.labelKategoriName.text = kategori.kategori_name
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toPlace", sender: indexPath.row)
    }
}
