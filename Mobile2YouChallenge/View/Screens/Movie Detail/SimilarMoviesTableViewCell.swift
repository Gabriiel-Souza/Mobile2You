//
//  SimilarMoviesTableViewCell.swift
//  Mobile2YouChallenge
//
//  Created by Gabriel Souza de Araujo on 04/01/22.
//

import UIKit

class SimilarMoviesTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "SimilarMoviesTableViewCell"
    
    private let movieImageView = UIImageView()
    private let titleLabel = UILabel()
    private let informationLabel = UILabel()
    private lazy var MovieLabelStackView: UIStackView = {
        let stackView = createStackView(with: [titleLabel, informationLabel], axis: .vertical)
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        selectionStyle = .none
        
        contentView.addSubview(movieImageView)
        contentView.addSubview(MovieLabelStackView)
        
        setupMovieData()
        setupImage()
        setupMovieLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMovieData() {
        movieImageView.image = UIImage(named: "TheJokerPoster")
        titleLabel.text = "The Joker"
        informationLabel.text = "1990 Drama, Fantasy"
    }
    
    private func setupImage() {
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.backgroundColor = .gray
        movieImageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: 9),
            movieImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9),
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 9),
            movieImageView.widthAnchor.constraint(equalTo: movieImageView.heightAnchor, multiplier: 1.0/1.4)
        ])
    }
    
    private func setupMovieLabels() {
        MovieLabelStackView.alignment = .leading
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .body).bold
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.tintColor = .systemGray
        
        informationLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        informationLabel.tintColor = .darkGray
        
        NSLayoutConstraint.activate([
            MovieLabelStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            MovieLabelStackView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 12),
            MovieLabelStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
