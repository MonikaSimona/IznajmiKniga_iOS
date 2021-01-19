//
//  KnigiCollectionViewController.swift
//  IznajmiKniga
//
//  Created by simona on 1/15/21.
//  Copyright © 2021 simona. All rights reserved.
//

import UIKit
import Parse

private let reuseIdentifier = "Cell"

class KnigiCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    var naslovi = [String]()
    var imageFiles = [PFFileObject]()
    var objectIds = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateCollection()
        
  
    }
    override func viewWillAppear(_ animated: Bool) {
        let myBackButton = UIBarButtonItem()
        myBackButton.title = "Назад"
        navigationItem.backBarButtonItem = myBackButton
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return naslovi.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! KnigaCollectionViewCell
        cell.contentView.layer.cornerRadius = 3.0
        
        cell.contentView.layer.masksToBounds = true;
        
        cell.layer.shadowColor = UIColor.gray.cgColor
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
                    cell.knigaImage.image = imageToDisplay
                }
            }
        }
        cell.naslov.text = naslovi[indexPath.row]
        
    
        return cell
    }
    
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
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detaliZaKniga" {
            if let cell = sender as? UICollectionViewCell, let index = collectionView.indexPath(for: cell){
                let destSeg = segue.destination as! DetaliZaKnigaViewController
                destSeg.objectId = objectIds[index.row]
            }
        }
    }
    
    func updateCollection(){
        self.naslovi.removeAll()
        self.imageFiles.removeAll()
        self.objectIds.removeAll()
        
        let knigaQuery = PFQuery(className: "Kniga")
        knigaQuery.findObjectsInBackground { (objects, error) in
            if let err = error{
                print(err.localizedDescription)
            }else if let knigi = objects{
                for kniga in knigi{
                    self.naslovi.append(kniga["naslov"] as! String)
                    self.imageFiles.append(kniga["imageFile"] as! PFFileObject)
                    self.objectIds.append(kniga.objectId!)
                    self.collectionView.reloadData()
                }
            }
        }
        
    }
  

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
