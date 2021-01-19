//
//  ProfilCitatelViewController.swift
//  IznajmiKniga
//
//  Created by simona on 1/14/21.
//  Copyright © 2021 simona. All rights reserved.
//

import UIKit
import Parse

class ProfilCitatelViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var newNameTextField: UITextField!
    @IBOutlet weak var newEmailTextField: UITextField!
    @IBOutlet weak var newPhoneTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let user = PFUser.current()
        nameLabel.text = user!["name"] as? String
        emailLabel.text = user?.email
        phoneLabel.text = user!["phone"] as? String
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let myBackButton = UIBarButtonItem()
        myBackButton.title = "Назад"
        navigationItem.backBarButtonItem = myBackButton
    }
    
    @IBAction func odjaviSe(_ sender: Any) {
        PFUser.logOut()
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func promeniPodatoci(_ sender: Any) {
        if newNameTextField.text == "" && newEmailTextField.text == "" && newPhoneTextField.text == "" && newPasswordTextField.text == ""{
            print("site polinja se prazni")
            displayAlert(title: "Грешка при промена на податоци", message: "Внесете поле за промена!")
        }else{
            
            let citatel = PFUser.current()
            if citatel != nil {
//                print(citatel?.username ?? "")
//                print(citatel!["name"] as! String)
                if self.newNameTextField.text != ""{
                   
                    citatel!["name"] = self.newNameTextField.text
                }
                if self.newEmailTextField.text != ""{
                    citatel?.username = "\(self.newEmailTextField.text ?? "")_citatel"
                    citatel?.email = self.newEmailTextField.text
                }
                if self.newPhoneTextField.text != ""{
                    citatel!["phone"] = self.newPhoneTextField.text
                    
                }
                if self.newPasswordTextField.text != ""{
                    citatel?.password = self.newPasswordTextField.text
                    
                }
            }
            citatel?.saveInBackground()
            
        
            
            if newNameTextField.text != ""{
                nameLabel.text = newNameTextField.text
            }
            if newEmailTextField.text != "" {
                emailLabel.text = newEmailTextField.text
            }
            if newPhoneTextField.text != ""{
                phoneLabel.text = newEmailTextField.text
            }
            
            if newPasswordTextField.text != "" {
                
                displayAlert(title:"Промена на податоци", message: "Успешно променета лозинка")
            }
            
            
            
            
            newNameTextField.text = ""
            newEmailTextField.text = ""
            newPhoneTextField.text = ""
            newPasswordTextField.text = ""
        }
       
        
    }
    @IBAction func konIznajmuvanja(_ sender: Any) {
        performSegue(withIdentifier: "moiIznajmuvanja", sender: self)
    }
    @IBAction func konKnigi(_ sender: Any) {
    }
    
    func displayAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        present(alertController,animated: true, completion: nil)
    }

}
