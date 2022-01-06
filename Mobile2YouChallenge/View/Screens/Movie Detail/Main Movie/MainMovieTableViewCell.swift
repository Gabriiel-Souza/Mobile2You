//
//  MainMovieTableViewCell.swift
//  Mobile2YouChallenge
//
//  Created by Gabriel Souza de Araujo on 04/01/22.
//

import UIKit

class MainMovieTableViewCell: UITableViewCell {
    
    private var movieImageView = UIImageView()
    
    private var isLiked = true
    
    // Title Background
    private var titleBackgroundView = UIView()
    private var titleLabel = UILabel()
    private var likeButton = UIButton()
    
    private var totalLikesImageView = UIImageView()
    private var totalLikesLabel = UILabel()
    
    private var totalViewsImageView = UIImageView()
    private var totalViewsLabel = UILabel()
    
    
    init(movie: Movie?) {
        super.init(style: .default, reuseIdentifier: "MainMovieTableViewCell")
        selectionStyle = .none
        
        // Subviews
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleBackgroundView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(likeButton)
        
        // Initial Configuration
        setupMovieData(movie)
        configureImage()
        configureTitleBackground()
        configureMovieTitleLabel()
        configureLikeButton()
        configureTotalLikes()
        configureTotalViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMovieData(_ movie: Movie?) {
        guard let movie = movie else { return }
        
        // Format total votes number
        var totalVotesCount = Double(movie.vote_count)
        var isMoreThanThousand = false
        
        if totalVotesCount > 1000 {
            totalVotesCount /= 1000
            isMoreThanThousand = true
        }
        
        var totalVotes = String(format: "%.1f", totalVotesCount)
        
        if isMoreThanThousand {
            totalVotes+="K"
        }
        
        totalVotes += " Likes"
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            // Title
            self.titleLabel.text = movie.title
            
            // Total Likes
            self.totalLikesLabel.text = totalVotes
            
            // Total Views
            self.totalViewsLabel.text = "\(movie.popularity) Views"
        }
    }
    
    func updateMovieImage(_ image: UIImage?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.movieImageView.image = image
        }
    }
    
    private func changeLikeButtonImage() {
        let buttonImage = UIImage(systemName: isLiked ? "suit.heart.fill" : "suit.heart")
        likeButton.setBackgroundImage(buttonImage, for: .normal)
    }
    
    @objc private func likeButtonPressed(sender: UIButton!) {
        isLiked.toggle()
        print("Like Button Pressed")
        changeLikeButtonImage()
    }
    
}

// MARK: - Constraints/Configs
extension MainMovieTableViewCell {
    private func configureImage() {
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.backgroundColor = .gray
        movieImageView.clipsToBounds = true
        movieImageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9)
        ])
    }
    
    private func configureTitleBackground() {
        titleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        titleBackgroundView.backgroundColor = .black
        NSLayoutConstraint.activate([
            titleBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleBackgroundView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25)
        ])
        
        // TODO: Apply Gradient
        //        let color = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        //        titleBackgroundView.applyGradient(isVertical: true, colors: [color, .black])
    }
    
    private func configureMovieTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .left
        titleLabel.textColor = .label
        
        let font = UIFont.preferredFont(forTextStyle: .title1).withSize(28)
        titleLabel.font = font.bold
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: titleBackgroundView.leadingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: titleBackgroundView.topAnchor, constant: -2),
            titleLabel.heightAnchor.constraint(equalTo: titleBackgroundView.heightAnchor, multiplier: 0.6),
            titleLabel.widthAnchor.constraint(equalTo: titleBackgroundView.widthAnchor, multiplier: 0.5)
        ])
    }
    
    private func configureLikeButton() {
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        // TODO: Verify if is a liked movie
        changeLikeButtonImage()
        likeButton.tintColor = .white
        likeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: titleBackgroundView.topAnchor, constant: 24),
            likeButton.trailingAnchor.constraint(equalTo: titleBackgroundView.trailingAnchor, constant: -8),
            likeButton.heightAnchor.constraint(equalTo: titleBackgroundView.heightAnchor, multiplier: 0.2),
            likeButton.widthAnchor.constraint(equalTo: likeButton.heightAnchor)
        ])
    }
    
    private func configureTotalLikes() {
        // Image View
        totalLikesImageView.image = UIImage(systemName: "suit.heart.fill")
        totalLikesImageView.tintColor = .white
        
        // Label
        let font = UIFont.preferredFont(forTextStyle: .subheadline)
        totalLikesLabel.font = font
        totalLikesLabel.tintColor = .darkGray
        
        let stackView = createStackView(with: [totalLikesImageView, totalLikesLabel], axis: .horizontal)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: titleBackgroundView.bottomAnchor, constant: -18),
            stackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
    }
    
    private func configureTotalViews() {
        // Image View
        totalViewsImageView.image = UIImage(systemName: "play.tv.fill")
        totalViewsImageView.tintColor = .white
        
        // Label
        let font = UIFont.preferredFont(forTextStyle: .subheadline)
        totalViewsLabel.font = font
        totalViewsLabel.tintColor = .darkGray
        
        let stackView = createStackView(with: [totalViewsImageView, totalViewsLabel], axis: .horizontal)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: titleBackgroundView.bottomAnchor, constant: -18),
            stackView.leadingAnchor.constraint(equalTo: totalLikesLabel.trailingAnchor, constant: 30)
        ])
    }
}
