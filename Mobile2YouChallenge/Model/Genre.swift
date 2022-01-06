//
//  Genre.swift
//  Mobile2YouChallenge
//
//  Created by Gabriel Souza de Araujo on 05/01/22.
//

import Foundation

struct Genres: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable {
    let id: Int
    let name: String
}
