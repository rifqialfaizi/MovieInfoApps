//
//  NetworkService.swift
//  MoviesApps
//
//  Created by Rifqi Alfaizi on 19/09/22.
//

import Foundation
import Alamofire
import MapKit

class NetworkService {
    
    static let shared = NetworkService()
    
    private let BASE_URL = "https://api.themoviedb.org/3"
    private let API_KEY = "PUT_YOUR_API_KEY_HERE"
    
    private var defaultParameters = ["":""]
    
    init() {
        defaultParameters = [
            "api_key": API_KEY,
            "language": "en-US"
        ]
    }
    
    func fetchMovies(page: Int, category: MovieCategory, completion: @escaping ((Result<MovieResponse, Error>) -> ())) {
        let url = "\(BASE_URL)/movie/\(category.rawValue)"
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        AF.request(url, method: .get, parameters: parameters).responseDecodable(of: MovieResponse.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchReviews(movieId: Int, completion: @escaping ((Result<[Review], Error>) -> ())) {
        let url = "\(BASE_URL)/movie/\(movieId)/reviews"
        var parameters = defaultParameters
        parameters["page"] = "1"
        AF.request(url, method: .get, parameters: parameters).responseDecodable(of: ReviewResponse.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchVideos(movieId: Int, completion: @escaping ((Result<[Video], Error>) -> ())) {
        let url = "\(BASE_URL)/movie/\(movieId)/videos"
        let parameters = defaultParameters
        AF.request(url, method: .get, parameters: parameters).responseDecodable(of: VideoResponse.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
