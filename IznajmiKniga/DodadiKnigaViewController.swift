//
//  DodadiKnigaViewController.swift
//  IznajmiKniga
//
//  Created by simona on 1/16/21.
//  Copyright © 2021 simona. All rights reserved.
//

import UIKit
import Parse

extension UIImage{
    enum JPEGQuality: CGFloat{
        case lowest  = 0
        case low = 0.25
        case medium = 0.5
        case high = 0.75
        case highest = 1
    }
    func jpeg(_ jpegQuality:JPEGQuality)->Data?{
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}

class DodadiKnigaViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var naslovTextField: UITextField!
    @IBOutlet weak var avtorTekstField: UITextField!
    @IBOutlet weak var sodrzinaTextView: UITextView!
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    
    @IBAction func konSiteKnigi(_ sender: Any) {
    }
    
    @IBAction func odberiSlika(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = image
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func dodadiKniga(_ sender: Any) {
        if let image = imageView.image{
            let kniga = PFObject(className: "Kniga")
            kniga["naslov"] = naslovTextField.text
            kniga["avtor"] = avtorTekstField.text
            kniga["sodrzina"] = sodrzinaTextView.text
            if let imagedata = image.jpeg(.medium){
                let imageFile = PFFileObject(name: "image.jpg", data: imagedata)
                kniga["imageFile"] = imageFile
                let naslov  = naslovTextField.text
                let avtor = avtorTekstField.text
                self.avtorTekstField.text = ""
                self.naslovTextField.text = ""
                self.sodrzinaTextView.text = ""
                self.imageView.image = nil
                kniga.saveInBackground()
                let messageStirng = "Додадена е '\(naslov ?? "")' од '\(avtor ?? "")'"
                self.displayAlert(title: "Успешно!", message: messageStirng)
                
            }
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
