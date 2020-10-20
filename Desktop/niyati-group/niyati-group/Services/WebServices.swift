//
//  WebServices.swift
//  niyati-group
//
//  Created by Kashee Kushwaha on 24/09/20.
//  Copyright © 2020 Kashee Kushwaha. All rights reserved.
//

import Foundation
import Alamofire

let baseUrl = "http://localhost:3000/"

struct AppUrls {
    static let restaurantsList = "restaurants"
}

struct NavTitles {
    static let restaurants = "Restaurants"
}


struct Webservices {
    
    static let shared = Webservices()
    
    func getGenericData<T: Decodable>(urlString: String, completion: @escaping (T) -> ()) {
        
        guard let url = URL(string: baseUrl + urlString)
            else {
                fatalError("Url is not correct")
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let posts = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(posts)
                }
            }catch(let err) {
                print(err)
            }
        }.resume()
    }
    
    func postGenericData<T: Decodable>(urlString: String, params: [String: AnyObject], completion: @escaping (Swift.Result<T, Error>) -> ()) {
        guard let url = URL(string: baseUrl + urlString) else { return }
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                do {
                    guard let data = response.data else { return }
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(decodedData))
                    }
                }catch let jsonError{
                    completion(.failure(jsonError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
