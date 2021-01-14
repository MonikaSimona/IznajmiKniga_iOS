//
//  ViewController.swift
//  IznajmiKniga
//
//  Created by simona on 1/12/21.
//  Copyright © 2021 simona. All rights reserved.
//

import UIKit
import Parse


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
    var tipKorisnik = "pocetok"
    
//    var alert = Alert()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(tipKorisnik)
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
                //se najavuva citatel ili bibliotekar
                let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                activityIndicator.center = view.center
                activityIndicator.hidesWhenStopped = true
                activityIndicator.style = UIActivityIndicatorView.Style.gray
                view.addSubview(activityIndicator)
                UIApplication.shared.beginIgnoringInteractionEvents()
                
                PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                    activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    if let err = error {
                        let errorString = err.localizedDescription
                        self.displayAlert(title: "Грешка при Најава", message: errorString)
                    }else{
                        if user!["type"] as! String == "citatel"{
                            print("Uspesna najava -  citatel")
                            self.performSegue(withIdentifier: "citatelSegue", sender: self)
                        }else{
                            print("Upesna najava - bibliotekar")
                             self.performSegue(withIdentifier: "bibliotekarSegue", sender: self)
                        }
                    }
                }
                
        
                
            }
        }else{
            if emailTextField.text == "" &&
                passwordTextField.text == "" &&
                nameTextField.text == "" &&
                phoneTextField.text == "" &&
                tipKorisnik == ""{
                
                displayAlert(title: "Грешка при Регистрација", message: "Треба да ги пополните сите полиња и да одберете тип на корисник")
                
            }else{
                let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                activityIndicator.center = view.center
                activityIndicator.hidesWhenStopped = true
                activityIndicator.style = UIActivityIndicatorView.Style.gray
                view.addSubview(activityIndicator)
                UIApplication.shared.beginIgnoringInteractionEvents()
                // se registrira citatel ili bibliotekar
                if tipKorisnik == "citatel" {
                    //se registrira citatel
                    let user = PFUser()
                    user.username = emailTextField.text! + "_citatel"
                    user.password = passwordTextField.text
                    user.email = emailTextField.text
                    user["name"] = nameTextField.text
                    user["phone"] = phoneTextField.text
                    user["type"] = tipKorisnik
                    
                    user.signUpInBackground { (success, error) in
                        activityIndicator.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        if let err = error {
                            let errorStirng = err.localizedDescription
                            self.displayAlert(title: "Грешка при регистрација", message: errorStirng)
                        }else{
                            print("Uspesna registracija - citatel")
                            self.performSegue(withIdentifier: "citatelSegue", sender: self)
                        }
                    }
                    
                }else{
                    // se registrira bibliotekar
                    let user = PFUser()
                    user.username = emailTextField.text! + "_bibliotekar"
                    user.password = passwordTextField.text
                    user.email = emailTextField.text
                    user["name"] = nameTextField.text
                    user["phone"] = phoneTextField.text
                    user["type"] = tipKorisnik
                    
                    user.signUpInBackground { (success, error) in
                        activityIndicator.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        if let err = error {
                            let errorStirng = err.localizedDescription
                            self.displayAlert(title: "Грешка при регистрација", message: errorStirng)
                        }else{
                            print("Uspesna registracija - bibliotekar")
                            self.performSegue(withIdentifier: "bibliotekarSegue", sender: self)
                        }
                    }
                }
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
    
    
    @IBAction func citatelPIcked(_ sender: UIButton) {
        tipKorisnik = "citatel"
        sender.setTitleColor(UIColor.lightGray, for: .normal)
        print(tipKorisnik)
    }
    
    @IBAction func bibliotekarPicked(_ sender: UIButton) {
        tipKorisnik = "bibliotekar"
        sender.setTitleColor(UIColor.lightGray, for: .normal)
        print(tipKorisnik)
    }
    
    func displayAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        present(alertController,animated: true, completion: nil)
    }
    
}


