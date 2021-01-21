//
//  DetaliZaIznajmuvanjeViewController.swift
//  IznajmiKniga
//
//  Created by simona on 1/16/21.
//  Copyright © 2021 simona. All rights reserved.
//

import UIKit
import Parse

class DetaliZaIznajmuvanjeViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    var objectId: String = ""
    var name:String = ""
    var email: String = ""
    var phone: String = ""
    var naslov: String = ""
    var author: String = ""
    var date: String = ""
    var status: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print("objId \(objectId)")
        nameLabel.text = name
        emailLabel.text = email
        phoneLabel.text = phone
        authorLabel.text = author
        titleLabel.text = naslov
        dateLabel.text = date
        if status == "iznajmeno"{
            statusLabel.text = "изнајмено"
        }else if status == "vrateno"{
            statusLabel.text = "вратено"
        }else {
            statusLabel.text = "доцни со враќање"
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
