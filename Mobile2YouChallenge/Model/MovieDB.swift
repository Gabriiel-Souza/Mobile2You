//
//  API.swift
//  Mobile2YouChallenge
//
//  Created by Gabriel Souza de Araujo on 05/01/22.
//

import UIKit
class MovieDB {
    
    static let shared = MovieDB()
    var genres = [Genre]()
    
    private init() {
        
    }
    
    // Genres Request
    func fetchGenres(completion: @escaping(Error?) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=526413961b6de91fefe105d4abb81eea&language=pt-BR") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, error == nil, let data = data else {
                completion(error)
                return
            }
            do {
                let genresFetched = try JSONDecoder().decode(Genres.self, from: data)
                self.genres = genresFetched.genres
                completion(nil)
            } catch {
                completion(error)
            }
        }.resume()
    }
    
    // Movies Requests
    func getMovie(id: Int, completion: @escaping(Result<MainMovie, Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=526413961b6de91fefe105d4abb81eea&language=pt-BR") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil, let data = data else {
                completion(.failure(error!))
                return
            }
            do {
                let movie = try JSONDecoder().decode(MainMovie.self, from: data)
                completion(.success(movie))
            } catch {
                completion(.failure(error))
            }
        }.resume()
        
    }
    
    func getSimilarMovies(id: Int, completion: @escaping(Result<[SimilarMovie], Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=526413961b6de91fefe105d4abb81eea&language=pt-BR") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil, let data = data else {
                completion(.failure(error!))
                return
            }
            do {
                let moviesResult = try JSONDecoder().decode(MoviesResult.self, from: data)
                completion(.success(moviesResult.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
