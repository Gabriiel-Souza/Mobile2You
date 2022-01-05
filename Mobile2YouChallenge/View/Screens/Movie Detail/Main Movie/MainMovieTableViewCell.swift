//
//  MainMovieTableViewCell.swift
//  Mobile2YouChallenge
//
//  Created by Gabriel Souza de Araujo on 04/01/22.
//

import UIKit

class MainMovieTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "MainMovieTableViewCell"
    
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
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleBackgroundView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(likeButton)
        
        setupImage()
        setupTitleBackground()
        setupMovieTitleLabel()
        setupLikeButton()
        setupTotalLikes()
        setupTotalViews()
        
        setupMovieData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // TODO: - Set real data to variables
    func setupMovieData() {
        movieImageView.image = UIImage(named: "TheJokerPoster")
        titleLabel.text = "The Joker"
        
        totalLikesLabel.text = "1.2K Likes"
        totalViewsLabel.text = "120.000 Views"
    }
    
    private func setupImage() {
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
    
    private func setupTitleBackground() {
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
    
    private func setupMovieTitleLabel() {
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
    
    private func changeLikeButtonImage() {
        let buttonImage = UIImage(systemName: isLiked ? "suit.heart.fill" : "suit.heart")
        likeButton.setBackgroundImage(buttonImage, for: .normal)
    }
    
    private func setupLikeButton() {
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
    
    @objc private func likeButtonPressed(sender: UIButton!) {
        isLiked.toggle()
        print("Like Button Pressed")
        changeLikeButtonImage()
    }
    
    private func createStackView(with views: [UIView]) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 5
        
        views.forEach({stackView.addArrangedSubview($0)})
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        return stackView
    }
    
    private func setupTotalLikes() {
        // Image View
        totalLikesImageView.image = UIImage(systemName: "suit.heart.fill")
        totalLikesImageView.tintColor = .white
        
        // Label
        let font = UIFont.preferredFont(forTextStyle: .subheadline)
        totalLikesLabel.font = font
        totalLikesLabel.tintColor = .darkGray
        
        let stackView = createStackView(with: [totalLikesImageView, totalLikesLabel])
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: titleBackgroundView.bottomAnchor, constant: -18),
            stackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
    }
    
    private func setupTotalViews() {
        // Image View
        totalViewsImageView.image = UIImage(systemName: "play.tv.fill")
        totalViewsImageView.tintColor = .white
        
        // Label
        let font = UIFont.preferredFont(forTextStyle: .subheadline)
        totalViewsLabel.font = font
        totalViewsLabel.tintColor = .darkGray
        
        let stackView = createStackView(with: [totalViewsImageView, totalViewsLabel])
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: titleBackgroundView.bottomAnchor, constant: -18),
            stackView.leadingAnchor.constraint(equalTo: totalLikesLabel.trailingAnchor, constant: 30)
        ])
    }
}
