//
//  API.swift
//  Mobile2YouChallenge
//
//  Created by Gabriel Souza de Araujo on 05/01/22.
//

import UIKit
class MovieDB {
    
    static let shared = MovieDB()
    
    private init() {
        
    }
    
    // Movies Requests
    func getMovie(name: String, completion: @escaping(Result<Movie, Error>) -> Void) {
        let nameFormatted = name.replacingOccurrences(of: " ", with: "+")
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=526413961b6de91fefe105d4abb81eea&query=\(nameFormatted)&language=pt-BR") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil, let data = data else {
                completion(.failure(error!))
                return
            }
            do {
                let movies = try JSONDecoder().decode(MoviesResult.self, from: data)
                if let movie = movies.results.first {
                    completion(.success(movie))
                } else {
                    completion(.failure(APIError.resultEmpty))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
        
    }
    
    // Images Requests
    func getImageData(from imagePath: String?, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        guard let path = imagePath, let url = URL(string: "https://image.tmdb.org/t/p/original/\(path)") else { return }
        
        return URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
