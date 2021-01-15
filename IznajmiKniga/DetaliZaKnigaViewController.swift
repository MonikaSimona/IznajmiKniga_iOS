//
//  DetaliZaKnigaViewController.swift
//  IznajmiKniga
//
//  Created by simona on 1/15/21.
//  Copyright © 2021 simona. All rights reserved.
//

import UIKit

class DetaliZaKnigaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
