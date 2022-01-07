//
//  MovieDetailViewModel.swift
//  Mobile2YouChallenge
//
//  Created by Gabriel Souza de Araujo on 04/01/22.
//

import UIKit

protocol MovieDetailDelegate: AnyObject {
    func refreshTableView()
    func presentNewMovie(_ movie: SimilarMovie)
}

final class MovieDetailViewModel: NSObject {
    private weak var delegate: MovieDetailDelegate?
    
    private let movieID: Int
    private var mainMovie: MainMovie?
    
    private var similarMovies = [SimilarMovie]()
    
    init(delegate: MovieDetailDelegate, movieID: Int) {
        self.movieID = movieID
        super.init()
        self.delegate = delegate
        getGenres()
    }
    
    // MARK: - Genres
    private func getGenres() {
        MovieDB.shared.fetchGenres { [weak self] _ in
            guard let self = self else { return }
            // Main Movie Essential Information
            self.getMainMovie()
        }
    }
    
    // MARK: - Main Movie
    private func getMainMovie() {
        MovieDB.shared.getMovie(id: movieID) { [weak self] result in
            guard let self = self else { return }
            do {
                let movie = try result.get()
                self.mainMovie = movie
                self.delegate?.refreshTableView()
                
                // Similar Movies Information
                self.getSimilarMovies()
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Similar Movies
    private func getSimilarMovies() {
        MovieDB.shared.getSimilarMovies(id: movieID) { [weak self] result in
            guard let self = self else { return }
            do {
                self.similarMovies = try result.get()
                self.delegate?.refreshTableView()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Table View Delegate
extension MovieDetailViewModel: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mainMovie == nil {
            return 0
        }
        
        // Similar movies + Main movie
        return similarMovies.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let mainMovieCell = tableView.dequeueReusableCell(withIdentifier: MainMovieTableViewCell.reuseIdentifier) as! MainMovieTableViewCell
            if let mainMovie = mainMovie {
                mainMovieCell.setupMovieData(mainMovie)
                mainMovieCell.updateLikeButtonImage()
            }
            return mainMovieCell
            
        } else {
            let index = indexPath.row-1
            let similarMovieCell = tableView.dequeueReusableCell(withIdentifier: SimilarMoviesTableViewCell.reuseIdentifier) as! SimilarMoviesTableViewCell
            similarMovieCell.setupMovieData(movie: similarMovies[index])
            return similarMovieCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UIScreen.main.bounds.height * 0.6
        } else {
            return UIScreen.main.bounds.height * 0.11
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Similar Movies are beginning in row 1
        if indexPath.row > 0 {
            let index = indexPath.row - 1
            delegate?.presentNewMovie(similarMovies[index])
        }
    }
}
