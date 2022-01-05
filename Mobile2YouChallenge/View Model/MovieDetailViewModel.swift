//
//  MovieDetailViewModel.swift
//  Mobile2YouChallenge
//
//  Created by Gabriel Souza de Araujo on 04/01/22.
//

import UIKit

protocol MovieDetailDelegate: AnyObject {
    
}

final class MovieDetailViewModel: NSObject {
    weak var delegate: MovieDetailDelegate?
    
    init(delegate: MovieDetailDelegate) {
        self.delegate = delegate
        
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
            return MainMovieTableViewCell(style: .default, reuseIdentifier: MainMovieTableViewCell.reuseIdentifier)
        } else {
            return SimilarMoviesTableViewCell(style: .default, reuseIdentifier: SimilarMoviesTableViewCell.reuseIdentifier)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UIScreen.main.bounds.height * 0.6
        } else {
            return UIScreen.main.bounds.height * 0.15
        }
    }
}
