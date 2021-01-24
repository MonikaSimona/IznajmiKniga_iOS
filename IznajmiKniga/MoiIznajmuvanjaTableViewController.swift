//
//  MoiIznajmuvanjaTableViewController.swift
//  IznajmiKniga
//
//  Created by simona on 1/24/21.
//  Copyright © 2021 simona. All rights reserved.
//

import UIKit
import Parse

class MoiIznajmuvanjaTableViewController: UITableViewController {

    var naslovi = [String]()
    var avtori =  [String]()
    var objectIds = [String]()
    var krajniDatumi = [String]()
    var statusi = [String]()
    var citatelId: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        citatelId = (PFUser.current()?.objectId)!
        
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
        
        let endDateString = krajniDatumi[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let endDate = dateFormatter.date(from:endDateString)!
        
        let dateNow = Date()
        
        
        let status = statusi[indexPath.row]
        if status == "vrateno"{
            cell.textLabel?.text = naslovi[indexPath.row]
            cell.detailTextLabel?.text = "Вратено"
            cell.detailTextLabel?.textColor = UIColor.init(red: 100, green: 0, blue: 0, alpha: 1)
            cell.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.35)
        }else if endDate < dateNow{
            cell.textLabel?.text = naslovi[indexPath.row]
            cell.detailTextLabel?.text = "Поминат рок - 30ден."
            cell.backgroundColor = UIColor.red
        }else{
            cell.textLabel?.text = naslovi[indexPath.row]
            cell.detailTextLabel?.text = "Да се врати до \(krajniDatumi[indexPath.row]) - 15ден."
        }
        
        
        
        
        return cell
    }
    
    func updateTable(){
        self.naslovi.removeAll()
        self.objectIds.removeAll()
        self.krajniDatumi.removeAll()
        self.statusi.removeAll()
        
        let query = PFQuery(className: "Iznajmuvanje")
        
        query.whereKey("citatelId", equalTo: citatelId)
        query.findObjectsInBackground { (objects, error) in
            if let err = error {
                print(err.localizedDescription)
            }else if let izn = objects{
                for iznajmuvanje in izn{
                    self.statusi.append(iznajmuvanje["status"] as! String)
                    self.objectIds.append(iznajmuvanje.objectId!)
                    self.krajniDatumi.append(iznajmuvanje["datumZaVrakjanje"] as! String)
                    self.naslovi.append(iznajmuvanje["naslov"] as! String)
                    self.avtori.append(iznajmuvanje["avtor"] as! String)
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

