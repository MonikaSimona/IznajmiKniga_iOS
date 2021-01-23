//
//  IznajmuvanjaBibliotekarTableViewController.swift
//  IznajmiKniga
//
//  Created by simona on 1/14/21.
//  Copyright © 2021 simona. All rights reserved.
//

import UIKit
import Parse


class IznajmuvanjaBibliotekarTableViewController: UITableViewController {
    var citateli = [String]()
    var names = [String]()
    var titles = [String]()
    var telefoni = [String]()
    var emails = [String]()
    var avtori = [String]()
    var datumi = [String]()
    var statusi = [String]()
    var naslovi = [String]()
    var objectIds = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTable()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let myBackButton = UIBarButtonItem()
        myBackButton.title = "Назад"
        navigationItem.backBarButtonItem = myBackButton
    }
  
    @IBAction func dodadiKnigaNavigation(_ sender: Any) {
    }
    
    
    @IBAction func odjaviSe(_ sender: Any) {
        PFUser.logOut()
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return citateli.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let citatelQuery = PFUser.query()
        citatelQuery?.getObjectInBackground(withId: citateli[indexPath.row], block: { (object, error) in
            if let err =  error{
                print(err.localizedDescription)
            }else if let citatel = object as? PFUser{
                
                self.names.append(citatel["name"] as! String)
                self.telefoni.append(citatel["phone"] as! String)
                self.emails.append(citatel.username!.components(separatedBy: "_")[0])
                cell.textLabel!.text = citatel["name"] as? String
            }
    })
        cell.detailTextLabel?.text = naslovi[indexPath.row]
        
//        let knigaQuery = PFQuery(className: "Kniga")
//        knigaQuery.getObjectInBackground(withId: naslovi[indexPath.row], block: { (object, error) in
//            if let err = error {
//                print(err.localizedDescription)
//            }else if let kniga = object{
//                if let title = kniga["naslov"] as? String{
//                    self.titles.append(title)
//                    cell.detailTextLabel!.text = title
//                }else {
//                    self.titles.append("не постои")
//                    cell.detailTextLabel!.text = "не постои"
//                }
//                if let avtor = kniga["avtor"] as? String{
//                    self.avtori.append(avtor)
//                }else {
//                    self.avtori.append("не постои")
//                }
//
//
//
//            }
//        })
        
        
        
//        cell.textLabel?.text = citateli[indexPath.row]
//        print(naslovi[indexPath.row])
//        cell.detailTextLabel?.text = naslovi[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detaliZaIznajmuvanje", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detaliZaIznajmuvanje" {
            if let index  = tableView.indexPathForSelectedRow?.row{
                let detaliIznajmuvanje = segue.destination as! DetaliZaIznajmuvanjeViewController
                detaliIznajmuvanje.objectId = objectIds[index]
                detaliIznajmuvanje.name = names[index]
                detaliIznajmuvanje.naslov = naslovi[index]
                detaliIznajmuvanje.author = avtori[index]
                detaliIznajmuvanje.date = datumi[index]
                detaliIznajmuvanje.email = emails[index]
                detaliIznajmuvanje.phone = telefoni[index]
                detaliIznajmuvanje.status = statusi[index]
                
                
                
            }
        }
    }
    func updateTable(){

        self.citateli.removeAll()
        self.naslovi.removeAll()
        self.objectIds.removeAll()
        self.telefoni.removeAll()
        self.emails.removeAll()
        self.avtori.removeAll()
        self.datumi.removeAll()
        self.statusi.removeAll()
        
        let query = PFQuery(className: "Iznajmuvanje")
        query.findObjectsInBackground { (objects, error) in
            if let err = error{
                print(err.localizedDescription)
                
            }else if let izn = objects{
                for iznjamuvanje in izn{
                    self.objectIds.append(iznjamuvanje.objectId!)
                    self.datumi.append(iznjamuvanje["datumIznajmeno"] as! String)
                    self.statusi.append(iznjamuvanje["status"] as! String)
                    self.citateli.append(iznjamuvanje["citatelId"] as! String)
                    self.naslovi.append(iznjamuvanje["naslov"] as! String)
                    self.avtori.append(iznjamuvanje["avtor"] as! String)
//                    if let knigaId = iznjamuvanje["knigaId"] as? String{
//                        let knigaQuery = PFQuery(className: "Kniga")
//                        knigaQuery.getObjectInBackground(withId: knigaId, block: { (object, error) in
//                            if let err = error {
//                                print(err.localizedDescription)
//                            }else if let kniga = object{
//                                self.naslovi.append(kniga["naslov"] as! String)
//                                self.avtori.append(kniga["avtor"] as! String)
//                                self.tableView.reloadData()
//                            }
//                        })
//                        if let citatelId = iznjamuvanje["citatelId"] as? String{
//                            let citatelQuery = PFUser.query()
//                            citatelQuery?.getObjectInBackground(withId: citatelId, block: { (object, error) in
//                                if let err =  error{
//                                    print(err.localizedDescription)
//                                }else if let citatel = object as? PFUser{
//                                    self.citateli.append(citatel["name"] as! String)
//                                    self.telefoni.append(citatel["phone"] as! String)
//                                    self.emails.append(citatel.username!.components(separatedBy: "_")[0])
//                                    self.tableView.reloadData()
//                                }
//                            })
//                        }
//                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
   
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

