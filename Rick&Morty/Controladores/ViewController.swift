/*
 Este View controller contiene la inicializacion de los botones para pasar a las diferentes tablas donde se obtendra la informacion
 */

import UIKit

class ViewController: UIViewController {
    //Variable --- visuales
    @IBOutlet weak var personajeView: UIView!
    @IBOutlet weak var episodioView: UIView!
    @IBOutlet weak var locacionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Ocultar barra y vistas
        personajeView.backgroundColor = .white
        episodioView.backgroundColor = .white
        locacionView.backgroundColor = .white
        
        //Agregar TapGesture a vistas
        let characterTap = UITapGestureRecognizer(target: self, action: #selector(handleCharacter))
        personajeView.addGestureRecognizer(characterTap)
        
        let chapterTap = UITapGestureRecognizer(target: self, action: #selector(handleChapter))
        episodioView.addGestureRecognizer(chapterTap)
        
        let locationTap = UITapGestureRecognizer(target: self, action: #selector(handleLocation))
        locacionView.addGestureRecognizer(locationTap)
    
    }
    //ocultar barra
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
   
    
    //manejadores de accion pasar controladores
    @objc func handleCharacter() {
        performSegue(withIdentifier: "personajes", sender: self)
    }
    @objc func handleChapter() {
        performSegue(withIdentifier: "episodios", sender: self)
    }
    @objc func handleLocation() {
        performSegue(withIdentifier: "locaciones", sender: self)
    }
    
}

