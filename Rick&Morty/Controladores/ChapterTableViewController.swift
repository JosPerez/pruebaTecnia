//
//  ChapterTableViewController.swift
//  Rick&Morty
//
//  Created by jose perez on 2019-02-26.
//  Copyright © 2019 jose perez. All rights reserved.
//

import UIKit

class ChapterTableViewController: UITableViewController {
    
    var episodio:[chapter] = []
    var limitRequest = 99
    let itemrequest = 20
    private var apiUrl = "https://rickandmortyapi.com/api/episode/"
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = false
        navigationController?.title = "Episodio"
        
        parseChapter(api: apiUrl)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return episodio.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterCell", for: indexPath) as? ChapterTableViewCell

        cell?.lbName.text = episodio[indexPath.row].name
        cell?.lbSeason.text = episodio[indexPath.row].episode
        cell?.lbAirDate.text = episodio[indexPath.row].airDate

        return cell!
    }
 

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == episodio.count-1 {
            if episodio.count < limitRequest {
                parseChapter(api: apiUrl)
                self.perform(#selector(reload), with: self, afterDelay: 2.0)

            }
        }
    }
    
    // Parsing Episodios
    func parseChapter(api:String) {
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
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let rickInfo = try decoder.decode(chapterInfo.self, from: data)
                    self.episodio.append(contentsOf: rickInfo.results!)
                    self.apiUrl = rickInfo.info?.next ?? ""
                    self.limitRequest = (rickInfo.info?.count)!
                }catch let error {
                    print(error)
                }
            }
            self.reload()
        }).resume()
    }
    @objc func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
