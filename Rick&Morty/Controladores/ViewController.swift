//
//  ViewController.swift
//  Rick&Morty
//
//  Created by jose perez on 2019-02-25.
//  Copyright © 2019 jose perez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Variable --- visuales
    @IBOutlet weak var personajeView: UIView!
    @IBOutlet weak var episodioView: UIView!
    @IBOutlet weak var locacionView: UIView!
    
    //Variables --- declarativas
    var personajes:[character] = []
    var episodios:[chapter] = []
    var locaciones:[location] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Ocultar barra y vistas
        navigationController?.navigationBar.isHidden = true
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
    
   
    
    //manejadores de accion pasar controladores
    @objc func handleCharacter() {
        performSegue(withIdentifier: "personajes", sender: self)
    }
    @objc func handleChapter() {
        print("Episodio")
    }
    @objc func handleLocation() {
        print("Locacion")
    }
    
    //Pasar informacion entre controlladores
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //code here------
    }
}

