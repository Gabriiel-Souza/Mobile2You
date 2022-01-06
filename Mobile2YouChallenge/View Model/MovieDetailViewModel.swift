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
    private var similarMovies: [Movie]?
    
    init(delegate: MovieDetailDelegate, movieTitle: String) {
        super.init()
        self.delegate = delegate
        // Essential information First
        MovieDB.shared.getMovie(name: movieTitle) { [weak self] result in
            guard let self = self else { return }
            do {
                let movie = try result.get()
                self.mainMovie = movie
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Change the values to Custom Cells
        if indexPath.row == 0 {
            let mainMovieCell = MainMovieTableViewCell(movie: mainMovie)
            
            return mainMovieCell
        } else {
            return SimilarMoviesTableViewCell(style: .default, reuseIdentifier: SimilarMoviesTableViewCell.reuseIdentifier)
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
