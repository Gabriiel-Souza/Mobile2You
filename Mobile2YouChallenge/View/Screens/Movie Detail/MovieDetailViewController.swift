//
//  MovieDetailViewController.swift
//  Mobile2YouChallenge
//
//  Created by Gabriel Souza de Araujo on 04/01/22.
//

import UIKit

class MovieDetailViewController: UIViewController, MovieDetailDelegate {
    
    var detailTableView = UITableView()
    var viewModel: MovieDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MovieDetailViewModel(delegate: self)
       
        setupTableView()
        
        // Register Table View Cells
        
        setupConstraints()
    }
    
    private func setupTableView() {
        view.addSubview(detailTableView)
        detailTableView.rowHeight = 100
        
        // Delegates
        detailTableView.delegate = viewModel
        detailTableView.dataSource = viewModel
        
    }
    
    private func setupConstraints() {
        detailTableView.edgesConstraints(to: view)
    }
}
