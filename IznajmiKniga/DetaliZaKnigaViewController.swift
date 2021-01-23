//
//  DetaliZaKnigaViewController.swift
//  IznajmiKniga
//
//  Created by simona on 1/15/21.
//  Copyright © 2021 simona. All rights reserved.
//

import UIKit
import Parse


class DetaliZaKnigaViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var sodrzina: UILabel!
    @IBOutlet weak var avtor: UILabel!
    @IBOutlet weak var naslov: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var objectId: String = ""
    var naslovKniga: String = ""
    var author: String = ""
    var citatelId: String = ""
    var iznajmi = true
    override func viewDidLoad() {
        super.viewDidLoad()
       button.layer.cornerRadius = 5
        citatelId = (PFUser.current()?.objectId)!
        
        let iznajmQuery = PFQuery(className: "Iznajmuvanje")
        iznajmQuery.whereKey("citatelId", equalTo: citatelId)
        iznajmQuery.whereKey("knigaId", equalTo: objectId)
        iznajmQuery.getFirstObjectInBackground { (object, error) in
            if let err = error {
                print(err.localizedDescription)
            }else if let iznajmuvanje = object{
                if let status = iznajmuvanje["status"] as? String{
                    if status == "iznajmeno"{
                        
                            self.iznajmi = false
                            self.button.setTitle(" Врати ", for: .normal)
                        
                    }
                }
            }
        }
        
        
        let knigaQuery = PFQuery(className: "Kniga")
        knigaQuery.getObjectInBackground(withId: objectId) { (object, error) in
            if let err = error{
                print(err.localizedDescription)
            }else if let kniga = object{
                self.naslov.text = kniga["naslov"] as? String
                self.avtor.text = kniga["avtor"] as? String
                self.sodrzina.text = kniga["sodrzina"] as? String
                if let imageFile = kniga["imageFile"] as? PFFileObject{
                    imageFile.getDataInBackground(block: { (data, error) in
                        if let imagedata = data {
                            if let img = UIImage(data: imagedata){
                                self.imageView.image = img
                            }
                        }
                    })
                }
            }
        }
        
        // Do any additional setup after loading the view.
    }

    
 
   
    
    @IBAction func iznajmi_vrati(_ sender: UIButton) {
        if iznajmi{
            button.setTitle(" Врати ", for: .normal)
            iznajmi = false
            let iznajmuvanje = PFObject(className: "Iznajmuvanje")
            
            let dateFormatter = DateFormatter()
            
            let date = Date()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let dateStringNow = dateFormatter.string(from: date)
            
            let dateInTwoWeeks = Calendar.current.date(byAdding: .weekOfYear, value: 2, to: Date())
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let dateStringInTwoWeeks = dateFormatter.string(from: dateInTwoWeeks!)
            
            iznajmuvanje["knigaId"] = objectId
            iznajmuvanje["naslov"] = naslovKniga
            iznajmuvanje["avtor"] = author
            iznajmuvanje["citatelId"] = citatelId
            iznajmuvanje["status"] = "iznajmeno"
            iznajmuvanje["datumIznajmeno"] = dateStringNow
            iznajmuvanje["datumZaVrakjanje"] = dateStringInTwoWeeks
            print(dateStringInTwoWeeks)
            iznajmuvanje.saveInBackground()
            print("iznajmeno")
            
            
        }else{
            let iznajmQuery = PFQuery(className: "Iznajmuvanje")
            iznajmQuery.whereKey("citatelId", equalTo: citatelId)
            iznajmQuery.whereKey("knigaId", equalTo: objectId)
            iznajmQuery.getFirstObjectInBackground { (object, error) in
                if let err = error {
                    print(err.localizedDescription)
                }else if let iznajmuvanje = object{
                  iznajmuvanje["status"] = "vrateno"
                    iznajmuvanje.saveInBackground()
                    self.button.setTitle(" Изнајми ", for: .normal)
                    self.iznajmi = true
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
