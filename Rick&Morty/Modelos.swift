//
//  Modelos.swift
//  Rick&Morty
//
//  Created by jose perez on 2019-02-26.
//  Copyright © 2019 jose perez. All rights reserved.
//

import Foundation
//Estructura para informacion base
struct info:Decodable {
    var count:Int?
    var pages:Int?
    var next:String?
    var prev:String?
}
//Estructura para personajes
struct ubicacion:Decodable {
    var name:String?
    var url:String?
}
struct character:Decodable{
    var id:Int?
    var name:String?
    var status:String?
    var species:String?
    var gender:String?
    var origin:ubicacion?
    var location:ubicacion?
    var image:String?
    var url:String?
    
}

struct characterInfo: Decodable {
    var info: info?
    var results:[character]?
}
//Estructura para Episodios
struct chapter : Decodable {
    var id:Int?
    var name:String?
    var airDate:String?
    var episode:String?
    var url:String?
    
   private enum codingKeys: String,CodingKey {
        case airDate = "air_date"
        case id,name,episode,url
    }
}

struct chapterInfo: Decodable {
    var info:info?
    var results:[chapter]?
}
//Estructura para Locaciones
struct location : Decodable {
    var id:Int?
    var name:String?
    var type:String?
    var dimension:String?
    var url:String?
}
struct locationInfo: Decodable {
    var info:info?
    var results:[location]?
}
