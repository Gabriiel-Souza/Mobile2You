//
//  MovieDetailViewModel.swift
//  Mobile2YouChallenge
//
//  Created by Gabriel Souza de Araujo on 04/01/22.
//

import UIKit

protocol MovieDetailDelegate: AnyObject {
    func refreshTableView()
}

final class MovieDetailViewModel: NSObject {
    private weak var delegate: MovieDetailDelegate?
    private var mainMovie: Movie?
    private var mainMovieImage: UIImage?
    private var similarMovies = [Movie]()
    
    init(delegate: MovieDetailDelegate, movieTitle: String) {
        super.init()
        self.delegate = delegate
        // Main Movie Essential Information
        getMainMovie(movieTitle: movieTitle)
    }
    
    // MARK: - Main Movie
    private func getMainMovie(movieTitle: String) {
        MovieDB.shared.getMovie(name: movieTitle) { [weak self] result in
            guard let self = self else { return }
            do {
                let movie = try result.get()
                self.mainMovie = movie
                self.delegate?.refreshTableView()
                // Similar Movies Information
                self.getSimilarMovies()
                // Update image after set essential data
                self.getMainMovieImage()
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func getMainMovieImage() {
        guard let mainMovie = mainMovie else { return }
        MovieDB.shared.getImageData(from: mainMovie.poster_path) { [weak self] data, _, error in
            guard let self = self else { return }
            guard error == nil, let data = data else { return }
            self.mainMovieImage = UIImage(data: data)
            self.delegate?.refreshTableView()
        }
    }
    
    //MARK: - Similar Movies
    private func getSimilarMovies() {
        guard let mainMovie = mainMovie else { return }
        MovieDB.shared.getSimilarMovies(id: mainMovie.id) { [weak self] result in
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
        // TODO: Change the value for the API result array count
        return similarMovies.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Change the values to Custom Cells
        if indexPath.row == 0 {
            let mainMovieCell = MainMovieTableViewCell(movie: mainMovie)
            if mainMovieImage != nil {
                mainMovieCell.updateMovieImage(mainMovieImage)
            }
            return mainMovieCell
        } else {
            let index = indexPath.row-1
            let similarMovieCell = SimilarMoviesTableViewCell(movie: similarMovies[index])
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
}
