//
//  ApiService.swift
//  Rest API
//
//  Created by Victor Vieira on 07/02/22.
//

import Foundation

protocol ApiServiceProtocol {
    func getPopularMoviesData(completion: @escaping (Result<MoviesData, Error>) -> Void)
}

class ApiServiceMock: ApiServiceProtocol {
    func getPopularMoviesData(completion: @escaping (Result<MoviesData, Error>) -> Void) {
        let movies: [Movie] = []
        completion(.success(.init(movies: movies)))
    }
}

class ApiService: ApiServiceProtocol {
    
    private var dataTask: URLSessionDataTask?
    
    let api_key = "api_key=69df030a50ccc58db4c288beaa4c218a"
    
    func getPopularMoviesData(completion: @escaping (Result<MoviesData, Error>) -> Void) {
        
        let popularMoviesURL = "https://api.themoviedb.org/3/movie/popular?\(api_key)"
        
        guard let url = URL(string: popularMoviesURL) else { return }
        
        //Create Url Session - Work on the Background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                //handle error
                if let error = error {
                    completion(.failure(error))
                    print("DataTask error: \(error.localizedDescription)")
                    return
                }
                 
                guard let response = response as? HTTPURLResponse else {
                    //Handle Empty Response
                    print("Empty Response")
                    return
                }
                print("Response Status Code: \(response.statusCode)")
                
                guard let data = data else {
                    //Handle Empty Data
                    print("Empty Data")
                    return
                }
                
                do {
                    //Parse the Data
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(MoviesData.self, from: data)
                    
                    completion(.success(jsonData))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }

        dataTask?.resume()
    }
    
}
