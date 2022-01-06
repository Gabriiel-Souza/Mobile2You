//
//  Movie.swift
//  Mobile2YouChallenge
//
//  Created by Gabriel Souza de Araujo on 05/01/22.
//

import Foundation

struct MoviesResult: Decodable {
    let page: Int
    let results: [SimilarMovie]
}

struct MainMovie: Decodable {
    let id: Int
    let title: String
    let poster_path: String?
    let popularity: Double
    let release_date: String
    let vote_count: Int
}

struct SimilarMovie: Decodable {
    let id: Int
    let title: String
    let poster_path: String?
    let popularity: Double
    let genre_ids: [Int]
    let release_date: String
    let vote_count: Int
}
