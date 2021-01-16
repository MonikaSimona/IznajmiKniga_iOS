//
//  DetaliZaKnigaViewController.swift
//  IznajmiKniga
//
//  Created by simona on 1/15/21.
//  Copyright © 2021 simona. All rights reserved.
//

import UIKit

class DetaliZaKnigaViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var sodrzina: UILabel!
    @IBOutlet weak var avtor: UILabel!
    @IBOutlet weak var naslov: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       button.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let myBackButton = UIBarButtonItem()
        myBackButton.title = "Назад"
        navigationItem.backBarButtonItem = myBackButton
    }
    

    @IBAction func iznajmi_vrati(_ sender: Any) {
        if button.titleLabel!.text == "Изнајми"{
            //kod za stavanje kniga vo baza
            //pocnuvanje iznajmuvanje
            print(button.titleLabel!.text!)
            print("iznajmeno")
            button.titleLabel!.text = "Врати"
        }else{
            //kod za prekinuvanje iznajmuvanje
            print(button.titleLabel!.text!)
            print("vrateno")
            button.titleLabel!.text = "Изнајми"
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
