//
//  ListaNasloviTableViewController.swift
//  IznajmiKniga
//
//  Created by simona on 1/18/21.
//  Copyright © 2021 simona. All rights reserved.
//

import UIKit
import Parse

class ListaNasloviTableViewController: UITableViewController {
    var naslovi = [String]()
    var avtori = [String]()
    var objectIds = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        isEditing = true
        updateTable()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return naslovi.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = naslovi[indexPath.row]
        cell.detailTextLabel?.text = avtori[indexPath.row]
      

        return cell
    }
 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let objectId = objectIds[indexPath.row]
            naslovi.remove(at: indexPath.row)
            avtori.remove(at: indexPath.row)
            objectIds.remove(at: indexPath.row)
            let deleteQuery = PFQuery(className: "Kniga")
            deleteQuery.getObjectInBackground(withId: objectId) { (kniga, error) in
                if let err = error {
                    print(err.localizedDescription)
                }else if let kniga = kniga  {
                    kniga.deleteInBackground()
                
                }
            }
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.bottom)
        }
        
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    func updateTable(){
        self.naslovi.removeAll()
        self.avtori.removeAll()
        self.objectIds.removeAll()
        let knigaQuery = PFQuery(className: "Kniga")
        knigaQuery.findObjectsInBackground { (knigi, error) in
            if let err = error {
                print(err.localizedDescription)
            }else if let knigi = knigi{
                for kniga in knigi {

                        if let naslov = kniga["naslov"] as? String{
                            if let avtor = kniga["avtor"] as? String{
                                if let objectId = kniga.objectId{
                                    self.naslovi.append(naslov)
                                    self.avtori.append(avtor)
                                    self.objectIds.append(objectId)
                                    self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }

}
