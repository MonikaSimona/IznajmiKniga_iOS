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
    
    @IBAction func odjaviSe(_ sender: Any) {
        PFUser.logOut()
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func promeniPodatoci(_ sender: Any) {
        if newNameTextField.text == "" && newEmailTextField.text == "" && newPhoneTextField.text == "" && newPasswordTextField.text == ""{
            print("site polinja se prazni")
            displayAlert(title: "Грешка при промена на податоци", message: "Внесете поле за промена!")
        }else{
            let query = PFUser.query()
            query?.whereKey("objectId", equalTo: PFUser.current()?.objectId ?? "")
            query?.getFirstObjectInBackground(block: { (user, error) in
                if let err = error{
                    print(err.localizedDescription)
                }else{
                    if let citatel = user as? PFUser{
                        if self.newNameTextField.text != ""{
                            citatel["name"] = self.newNameTextField.text
                        }
                        if self.newEmailTextField.text != ""{
                            citatel.email = self.newEmailTextField.text
                        }
                        if self.newPhoneTextField.text != ""{
                            citatel["phone"] = self.newPhoneTextField.text
                        }
                        if self.newPasswordTextField.text != ""{
                            citatel.password = self.newPasswordTextField.text
                        }
                    }
                }
            })
            
            nameLabel.text = newNameTextField.text
            emailLabel.text = newEmailTextField.text
            phoneLabel.text = newPasswordTextField.text
            
            
            newNameTextField.text = ""
            newEmailTextField.text = ""
            newPhoneTextField.text = ""
            newPasswordTextField.text = ""
        }
       
        
    }
    @IBAction func konIznajmuvanja(_ sender: Any) {
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
