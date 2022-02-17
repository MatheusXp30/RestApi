//
//  ViewController.swift
//  Rest API
//
//  Created by Victor Vieira on 06/02/22.
//

import UIKit
// O UIKit já implementa Foundation
// Command shift R executa direto sem buildar

class MovieViewController: UIViewController {
    private var baseView = MovieView()
    
    private var viewModel = MovieViewModel(apiService: ApiService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadUpComingMoviesData()
    }
    
    override func loadView() {
        view = baseView
    }
    
    private func loadUpComingMoviesData() {
        viewModel.fetchPopularMoviesData { [weak self] in
            self?.baseView.tableView.reloadData()
        }
    }
    
    private func configureTableView() {
        baseView.tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.reuseIdentifier)
        baseView.tableView.dataSource = self
    }
}

// MARK: - UITableViewDataSource extension
extension MovieViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseIdentifier, for: indexPath) as? MovieTableViewCell else { return .init() }
        
        let movie = viewModel.cellForRow(at: indexPath)
        cell.setCellWithValuesOf(movie)
        
        return cell
    }
    
}

