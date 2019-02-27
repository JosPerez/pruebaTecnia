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

        navigationController?.title = "Informacion"
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
            return (personaje.episode?.count)!
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
            var episodeNumber = personaje.episode![indexPath.row]
            var index = episodeNumber.range(of: "/", options: .backwards, range: nil, locale: nil)?.lowerBound
            index = episodeNumber.index(index!, offsetBy: 1)
            episodeNumber = episodeNumber.substring(from: index!)
            cell?.textLabel!.text = "Episodio \(episodeNumber)";
            
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
                
                let size = self.personajeImagen.size
                
                let widthRatio  = 110  / size.width
                let heightRatio = 98 / size.height
                
                var newSize: CGSize
                if widthRatio > heightRatio {
                    newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
                } else {
                    newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
                }
                
                let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
                
                UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
                self.personajeImagen.draw(in: rect)
                let newImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                self.personajeImagen = newImage
                
                self.tableView.reloadData()
            }
        }).resume()
    }

}
