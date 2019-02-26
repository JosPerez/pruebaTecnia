//
//  DetailCharacterTableViewController.swift
//  Rick&Morty
//
//  Created by jose perez on 2019-02-26.
//  Copyright © 2019 jose perez. All rights reserved.
//

import UIKit

class DetailCharacterTableViewController: UITableViewController {

    //Variable contenedoras
    var personaje:character!
    var personajeImagen:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section ==  0 {
             return 1
        }else {
            return 5
        }
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        }else {
            return "Episodios"
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "header") as? DetailCharacterTableViewCell
            
            cell?.lbName.text = personaje.name
            cell?.lbStatus.text = personaje.status
            cell?.lbSpecies.text = personaje.species
            cell?.lbGender.text = personaje.gender
            cell?.lbOrigin.text = personaje.origin?.name
            cell?.lbLocation.text = personaje.location?.name
            cell?.imageView?.image = personajeImagen
            
            return cell!
            
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "episodios")
            
            cell?.textLabel!.text = "1";
            
            return cell!
        }
        
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let url = URL(string: personaje.image!) else {
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: {(data,response,error) in
            DispatchQueue.main.async {
                
                guard let image = data else {
                    return
                }
                
                self.personajeImagen = UIImage(data: image)
                
                self.tableView.reloadData()
            }
        }).resume()
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
