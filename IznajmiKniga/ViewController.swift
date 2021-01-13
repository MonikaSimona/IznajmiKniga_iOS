//
//  ViewController.swift
//  IznajmiKniga
//
//  Created by simona on 1/12/21.
//  Copyright © 2021 simona. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bibliotekarButton: UIButton!
    @IBOutlet weak var citatelButton: UIButton!
    @IBOutlet weak var separatorLine: UILabel!
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var topButton: UIButton!
    var voNajava = true
    var tipKorisnik = ""
    
//    var alert = Alert()
    override func viewDidLoad() {
        super.viewDidLoad()
        topButton.layer.cornerRadius = 5
        
        separatorLine.isHidden = true
        label.isHidden = true
        citatelButton.isHidden = true
        bibliotekarButton.isHidden = true
        nameTextField.isHidden = true
        phoneTextField.isHidden = true
    }


    @IBAction func topButtonPressed(_ sender: Any) {
        if voNajava{
            if emailTextField.text == "" &&
                passwordTextField.text == "" {
                
                displayAlert(title: "Грешка при Најава", message: "Треба да внесете и емаил и лозинка")
                
            }else{
                
            }
        }else{
            if emailTextField.text == "" &&
                passwordTextField.text == "" &&
                nameTextField.text == "" &&
                phoneTextField.text == "" &&
                tipKorisnik == ""{
                
                displayAlert(title: "Грешка при Регистрација", message: "Треба да ги пополните сите полиња и да одберете тип на корисник")
                
            }else{
                
            }
        }
       
    }
    
    
    @IBAction func bottomButtonPressed(_ sender: Any) {
        if voNajava {
            topButton.setTitle(" Регистрирај Се ", for: .normal)
            topButton.sizeToFit()
            bottomButton.setTitle("Премини кон Најава", for: .normal)
            
            voNajava = false
            
            separatorLine.isHidden = false
            label.isHidden = false
            citatelButton.isHidden = false
            bibliotekarButton.isHidden = false
            nameTextField.isHidden = false
            phoneTextField.isHidden = false
        }else{
            topButton.setTitle(" Најави Се ", for: .normal)
            topButton.sizeToFit()
            bottomButton.setTitle("Премни кон Регистрација", for: .normal)
            
            voNajava = true
            
            separatorLine.isHidden = true
            label.isHidden = true
            citatelButton.isHidden = true
            bibliotekarButton.isHidden = true
            nameTextField.isHidden = true
            phoneTextField.isHidden = true
        }
    }
    
    func displayAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        present(alertController,animated: true, completion: nil)
    }
    
}


