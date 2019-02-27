/*
 Controlador de locaciones donde se muestra las diferentes ubicaciones que apaerecen en la serie extraidas del API
 */

import UIKit

class LocationTableViewController: UITableViewController {
    
    var ubicaciones:[location] = []
    var limitRequest = 99
    let itemrequest = 20
    private var apiUrl = "https://rickandmortyapi.com/api/location/"
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Locaciones"

        
        parseLocation(api: apiUrl)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ubicaciones.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as? LocationTableViewCell

        // Configure the cell...
        cell?.lbNombre.text = ubicaciones[indexPath.row].name!
        cell?.lbTipo.text = ubicaciones[indexPath.row].type!
        cell?.lbDimension.text = ubicaciones[indexPath.row].dimension

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == ubicaciones.count-1 {
            if ubicaciones.count < limitRequest {
                parseLocation(api: apiUrl)
                self.perform(#selector(reload), with: self, afterDelay: 2.0)
            }
            
        }
    }

    //Parsing Location
    func parseLocation(api:String) {
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
                    let rickInfo = try decoder.decode(locationInfo.self, from: data)
                    self.ubicaciones.append(contentsOf: rickInfo.results!)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
