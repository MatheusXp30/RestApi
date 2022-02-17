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
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular Movies"
        label.textColor = .white
        label.backgroundColor = .black
        label.font = .systemFont(ofSize: 27)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var viewModel = MovieViewModel(apiService: ApiService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        configureTableView()
        loadUpComingMoviesData()
    }
    
    private func loadUpComingMoviesData() {
        viewModel.fetchPopularMoviesData { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func configureTableView() {
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.reuseIdentifier)
        tableView.dataSource = self
    }
    
    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 60),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
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

