//
//  CharacterTableViewController.swift
//  Rick&Morty
//
//  Created by jose perez on 2019-02-25.
//  Copyright © 2019 jose perez. All rights reserved.
//

import UIKit

class CharacterTableViewController: UITableViewController {
    
    //arreglo para guardar caracteres
    var personajes:[character] = []
    var limitRequest = 999
    let itemRequest = 20
    private var apiUrl = "https://rickandmortyapi.com/api/character/"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false;
        
        //tableView.tableFooterView = UIView(frame: .zero)
        parseCharacter(api: apiUrl)
    }
    //Sintetizar JSON dentro una variable
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return personajes.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? CharacterTableViewCell
        
        cell?.lbNombre.text = personajes[indexPath.row].name!
        cell?.lbStatus.text = personajes[indexPath.row].status!
        
        
        
        // Configure the cell...

        return cell!
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == personajes.count-1 {
            if personajes.count < limitRequest {
                parseCharacter(api: apiUrl)
            }
            self.perform(#selector(reload), with: self, afterDelay: 2.0)
        }
    }
    @objc func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    //LLamadas a API
    func parseCharacter(api:String) {
        guard let url = URL(string: api) else {
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: {(data,response,error) in
            DispatchQueue.main.async {
                guard let data = data else {
                    print("Infromacion no se puedo Fetchear")
                    return
                }
                do {
                    
                    let rickInfo = try JSONDecoder().decode(characterInfo.self, from: data)
                    self.personajes.append(contentsOf: rickInfo.results!)
                    self.apiUrl = rickInfo.info?.next ?? ""
                    self.limitRequest = (rickInfo.info?.count)!
                }catch let error {
                    print(error)
                }
            }
            self.reload()
        }).resume()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            
            let detailTVC = segue.destination as? DetailCharacterTableViewController
            let index = self.tableView.indexPathForSelectedRow!
            detailTVC?.personaje = personajes[index.row]
            
            
        }
    }
    
    

}
