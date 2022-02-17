//
//  MovieViewModel.swift
//  Rest API
//
//  Created by Victor Vieira on 07/02/22.
//

import Foundation

class MovieViewModel {
    
    private let apiService: ApiServiceProtocol
    
    // Injeção de dependência
    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
    }
    
    private var popularMovies = [Movie]()
    
    func fetchPopularMoviesData(completion: @escaping() -> () ) {
        apiService.getPopularMoviesData { [weak self] result in
            switch result {
            case .success(let response):
                self?.popularMovies = response.movies ?? []
                completion()
                
            case .failure(let error):
                print("Error Processing json data: \(error)")
            }
        }
    }
    
    func numberOfRows() -> Int {
        popularMovies.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> Movie {
        // popularMovies.indices.contains(indexPath.row)
        popularMovies[indexPath.row]
    }
}
