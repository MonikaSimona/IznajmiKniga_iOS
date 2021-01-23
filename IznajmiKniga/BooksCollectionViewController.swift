//
//  BooksCollectionViewController.swift
//  IznajmiKniga
//
//  Created by simona on 1/23/21.
//  Copyright © 2021 simona. All rights reserved.
//

import UIKit
import Parse

class BooksCollectionViewController: UIViewController {

   
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var prebarajButton: UIButton!
    @IBOutlet weak var naslovButton: UIButton!
    @IBOutlet weak var avtorButton: UIButton!
    var key = ""
    var naslovi = [String]()
    var avtori = [String] ()
    var imageFiles = [PFFileObject]()
    var objectIds = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        prebarajButton.layer.cornerRadius = 5
        updateCollection()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let myBackButton = UIBarButtonItem()
        myBackButton.title = "Назад"
        navigationItem.backBarButtonItem = myBackButton
    }
    
    @IBAction func poNaslov(_ sender: Any) {
        let currentColor = naslovButton.currentTitleColor
        let currentShadow = naslovButton.currentTitleShadowColor
        naslovButton.setTitleColor(UIColor.lightGray, for: .normal)
        naslovButton.setTitleShadowColor(UIColor.init(red: 102, green: 27, blue: 20, alpha: 1), for: UIControl.State.normal)
       
        avtorButton.setTitleColor(currentColor, for: .normal)
        avtorButton.setTitleShadowColor(currentShadow, for: .normal)
        key = "naslov"
        
    }
    @IBAction func poAvtor(_ sender: Any) {
        let currentColor = avtorButton.currentTitleColor
         let currentShadow = avtorButton.currentTitleShadowColor
        avtorButton.setTitleColor(UIColor.lightGray, for: .normal)
         avtorButton.setTitleShadowColor(UIColor.init(red: 102, green: 27, blue: 20, alpha: 1), for: UIControl.State.normal)
        naslovButton.setTitleColor(currentColor, for: .normal)
        naslovButton.setTitleShadowColor(currentShadow, for: .normal)
        key = "avtor"
    }
    @IBAction func prebarajNaslov(_ sender: Any) {
        let searchString = titleTextField.text
        self.naslovi.removeAll()
        self.avtori.removeAll()
        self.imageFiles.removeAll()
        self.objectIds.removeAll()
        
        let query = PFQuery(className: "Kniga")
        
        query.whereKey(key, contains: searchString?.capitalized )
        query.findObjectsInBackground { (objects, error) in
            if let err = error{
                print(err.localizedDescription)
            }else if let knigi = objects{
                for kniga in knigi{
                    self.naslovi.append(kniga["naslov"] as! String)
                    self.avtori.append(kniga["avtor"] as! String)
                    self.imageFiles.append(kniga["imageFile"] as! PFFileObject)
                    self.objectIds.append(kniga.objectId!)
                    self.collectionView.reloadData()
                }
            }
        }
        
        
    }
    func updateCollection(){
        self.naslovi.removeAll()
        self.avtori.removeAll()
        self.imageFiles.removeAll()
        self.objectIds.removeAll()
        
        let knigaQuery = PFQuery(className: "Kniga")
        knigaQuery.findObjectsInBackground { (objects, error) in
            if let err = error{
                print(err.localizedDescription)
            }else if let knigi = objects{
                for kniga in knigi{
                    self.naslovi.append(kniga["naslov"] as! String)
                    self.avtori.append(kniga["avtor"] as! String)
                    self.imageFiles.append(kniga["imageFile"] as! PFFileObject)
                    self.objectIds.append(kniga.objectId!)
                    self.collectionView.reloadData()
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detali" {
            if let cell = sender as? UICollectionViewCell, let index = collectionView.indexPath(for: cell){
                let destSeg = segue.destination as! DetaliZaKnigaViewController
                destSeg.objectId = objectIds[index.row]
                destSeg.author = avtori[index.row]
                destSeg.naslovKniga = naslovi[index.row]
            }
        }
    }
   

}


extension BooksCollectionViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return naslovi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DataCollectionViewCell
        cell.contentView.layer.cornerRadius = 3.0
        
        cell.contentView.layer.masksToBounds = true;
        
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width:0,height: 2.0)
        cell.layer.shadowRadius = 3.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false;
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        
        
        imageFiles[indexPath.row].getDataInBackground { (data, error) in
            if let err = error{
                print(err.localizedDescription)
            }else if let imageData = data{
                if let imageToDisplay = UIImage(data: imageData){
                    cell.BookImage.image = imageToDisplay
                }
            }
        }
        cell.BookTitle.text = naslovi[indexPath.row]
        
        
        
        return cell
    }
    
    
}

extension BooksCollectionViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        return CGSize(width: bounds.width / 2 - 6, height: bounds.height / 2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}
