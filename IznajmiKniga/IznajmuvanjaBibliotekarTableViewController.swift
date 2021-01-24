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
    var krajniDatumi = [String] ()
    var statusi = [String]()
    var naslovi = [String]()
    var objectIds = [String]()
    var pominat_rok = false
    
    
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
        
        let endDateString = krajniDatumi[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let endDate = dateFormatter.date(from:endDateString)!
        
        let dateNow = Date()
        
        if endDate < dateNow {
            pominat_rok = true
        }
        

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
                if pominat_rok{
                    detaliIznajmuvanje.status = "поминат рок"
                }else{
                    detaliIznajmuvanje.status = statusi[index]
                }
                
                
                
                
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
        self.krajniDatumi.removeAll()
        
        let query = PFQuery(className: "Iznajmuvanje")
        query.findObjectsInBackground { (objects, error) in
            if let err = error{
                print(err.localizedDescription)
                
            }else if let izn = objects{
                for iznjamuvanje in izn{
                    self.objectIds.append(iznjamuvanje.objectId!)
                    self.datumi.append(iznjamuvanje["datumIznajmeno"] as! String)
                    self.krajniDatumi.append(iznjamuvanje["datumZaVrakjanje"] as! String)
                    self.statusi.append(iznjamuvanje["status"] as! String)
                    self.citateli.append(iznjamuvanje["citatelId"] as! String)
                    self.naslovi.append(iznjamuvanje["naslov"] as! String)
                    self.avtori.append(iznjamuvanje["avtor"] as! String)

                    self.tableView.reloadData()
                }
            }
        }
    }
   
 

}

