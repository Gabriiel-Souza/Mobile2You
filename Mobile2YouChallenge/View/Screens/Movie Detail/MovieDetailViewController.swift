//
//  MovieDetailViewController.swift
//  Mobile2YouChallenge
//
//  Created by Gabriel Souza de Araujo on 04/01/22.
//

import UIKit

class MovieDetailViewController: UIViewController, MovieDetailDelegate {
    
    var detailTableView = UITableView()
    let movieID: Int
    var viewModel: MovieDetailViewModel?
    
    init(movieID: Int) {
        self.movieID = movieID
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        configureNavBar()
        
        detailTableView.contentInsetAdjustmentBehavior = .never
        viewModel = MovieDetailViewModel(delegate: self,
                                         movieID: movieID)
        
        setupTableView()
        
        // Register Table View Cells
        setupConstraints()
    }
    
    // MARK: - Navigation Bar
    private func configureNavBar() {
        var backImageConfig = UIButton.Configuration.plain()
        let image = UIImage(systemName: "chevron.backward")
        backImageConfig.image = image
        let symbolConfig = UIImage.SymbolConfiguration(paletteColors: [.white, .black])
        backImageConfig.preferredSymbolConfigurationForImage = symbolConfig
        
        let size = view.frame.width * 0.08
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: size, height: size))
        backButton.configuration = backImageConfig
        backButton.backgroundColor = .black
        backButton.layer.cornerRadius = backButton.frame.width / 2.0
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: backButton)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: size).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: size).isActive = true
        
        navigationItem.leftBarButtonItem = menuBarItem
    }
    
    @objc private func backButtonPressed(sender: UIButton) {
        guard let vcNumber = navigationController?.viewControllers.count else { return }
        if vcNumber > 1 {
            navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Setups
    private func setupTableView() {
        detailTableView.frame = view.bounds
        detailTableView.delaysContentTouches = false
        view.addSubview(detailTableView)
        
        // Delegates
        detailTableView.delegate = viewModel
        detailTableView.dataSource = viewModel
    }
    
    private func setupConstraints() {
        detailTableView.edgesConstraints(to: view)
    }
}

// MARK: - Movie Detail Delegate
extension MovieDetailViewController {
    
    func refreshTableView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.detailTableView.reloadData()
        }
    }
    
    func presentNewMovie(_ movie: SimilarMovie) {
        let movieDetailVC = MovieDetailViewController(movieID: movie.id)
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}
