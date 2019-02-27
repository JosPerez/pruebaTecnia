/*
 Controlador de la vista de personajes, en el cual se crea una celda personalizada para mostar nombre y estatus de todos los personajes de la serie Rick and Morty, donde se obtiene la informacion de la api mediante URLsession nativo
 
 */

import UIKit

class CharacterTableViewController: UITableViewController {
    
    //arreglo para guardar caracteres
    var personajes:[character] = []
    //Variables de control de datos, para la obtencion de informacion cada 20 items
    var limitRequest = 999
    let itemRequest = 20
    private var apiUrl = "https://rickandmortyapi.com/api/character/"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Se muestra la barra de navegador y asigna un titulo
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Personajes"
        //  Se obtinee la pirmera pagina del JSON
        parseCharacter(api: apiUrl)
        
    }
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
        return 70
    }
    //Adapatacion de la celda personalizada y asiganacion  de datos
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? CharacterTableViewCell
        
        cell?.lbNombre.text = personajes[indexPath.row].name!
        cell?.lbStatus.text = personajes[indexPath.row].status!
        
        
        
        // Configure the cell...

        return cell!
    }
    //Funcion para recargar informacion en la tabla despues de alcanzar el limite inferior y obtener nueva informacion
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == personajes.count-1 {
            if personajes.count < limitRequest {
                parseCharacter(api: apiUrl)
                self.perform(#selector(reload), with: self, afterDelay: 2.0)

            }
        }
    }
    //Funcion auxiliar para recargar la informacion despues de que termine de bajar los items
    @objc func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    //LLamadas a API
    func parseCharacter(api:String) {
        //Se utiliza el guard para verfiricar si la URL es valida
        guard let url = URL(string: api) else {
            return
        }
        //Inicio de sesion para llamada a la api con regreso de respuesta-error- data
        URLSession.shared.dataTask(with: url, completionHandler: {(data,response,error) in
            //Se inicia una llamada Asyncronica para ponder en FIFO la extraccion y recarga de datos
            DispatchQueue.main.async {
                //Verifica la extracion exitosa de la informacion
                guard let data = data else {
                    print("Infromacion no se puedo Fetchear")
                    return
                }
                
                //Se hace un do-catch para la decodificacion  de JSON con patron especifico en este caso de informacion del personaje
                //Se actuliza en numero verdadero de items y la nueva URL
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
    
    //Se pasa el personaje seleccionado al sigueinte view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            
            let detailTVC = segue.destination as? DetailCharacterTableViewController
            let index = self.tableView.indexPathForSelectedRow!
            detailTVC?.personaje = personajes[index.row]
            
            
        }
    }
    
    

}
