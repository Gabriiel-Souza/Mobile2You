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
    func scrollViewDidScroll()
}

final class MovieDetailViewModel: NSObject {
    private weak var delegate: MovieDetailDelegate?
    
    private let movieID: Int
    private var mainMovie: MainMovie?
    
    private var mainMovieCellHeight = UIScreen.main.bounds.height * 0.55
    private var similarMovieCellHeight = UIScreen.main.bounds.height * 0.11
    private let cellsMargin = UIEdgeInsets.init(top: 0, left: UIScreen.main.bounds.width * 0.2, bottom: 0, right: 0)
    
    private var similarMovies = [SimilarMovie]()
    private var favoriteMovies = [Int32]()
    
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
                if let favoriteMovies = PersistenceController.shared.fetchFavoriteMovies() {
                    self.favoriteMovies = favoriteMovies.map { $0.id }
                }
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
            mainMovieCell.separatorInset.left = UIScreen.main.bounds.width
            
            return mainMovieCell
        } else {
            let index = indexPath.row-1
            let similarMovieCell = tableView.dequeueReusableCell(withIdentifier: SimilarMoviesTableViewCell.reuseIdentifier) as! SimilarMoviesTableViewCell
            
            let similarMovie = similarMovies[index]
            let isFavorite = favoriteMovies.contains(Int32(similarMovie.id))
            
            similarMovieCell.setupMovieData(movie: similarMovie, isFavorite: isFavorite)
            similarMovieCell.layoutMargins = cellsMargin
            
            return similarMovieCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return mainMovieCellHeight
        } else {
            return similarMovieCellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Similar Movies are beginning in row 1
        if indexPath.row > 0 {
            let index = indexPath.row - 1
            delegate?.presentNewMovie(similarMovies[index])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll()
    }
}
