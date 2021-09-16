//
//  NetworkManager.swift
//  GamerApp
//
//  Created by Eren Erinanç on 11.09.2021.
//

import Foundation

enum CustomError: String, Error {
    case invalidRequest = "This URL does not exist"
    case invalidData = "Data can not be converted"
    case invalidResponse = "Response is not valid"
    case unableToComplete = "Network Error"
}

struct APIRequest {
    let baseURL = "https://rawg-video-games-database.p.rapidapi.com"
    let headers = [
        "X-RapidAPI-Key": "2ee709ec5cmsh6bac39279abbb63p18f646jsnb351c7bd6d82",
        "X-RapidAPI-Host": "rawg-video-games-database.p.rapidapi.com"
    ]
    var queryItems: [URLQueryItem] {
        var itemArray = [URLQueryItem(name: "key", value: "11c8d4f22be54efe9944f5d1984e3b7b")]
        for (name,value) in parameters {
            itemArray.append(URLQueryItem(name: name, value: value))
        }
        return itemArray
    }
    
    let path: String
    let parameters: [String:String]
}
    
class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetch<T:Decodable>(request: APIRequest,model: T.Type, completion: @escaping (Result<T,CustomError>) -> Void) {
        var urlComponents = URLComponents(string: request.baseURL + request.path)!
        urlComponents.queryItems = request.queryItems

        var urlRequest = URLRequest(url: urlComponents.url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        let headers = request.headers
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                completion(.failure(.invalidData))
                print(CustomError.invalidData)
                return
            }

            if let _ = error {
                completion(.failure(.unableToComplete))
                print(CustomError.unableToComplete)
                return
            } else {
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let apiResponse = try decoder.decode(model.self, from: data)
                        completion(.success(apiResponse))
                    }
                    catch {
                        completion(.failure(.invalidData))
                        print(CustomError.invalidData)
                    }
                } else {
                    print("Status code: \((response as! HTTPURLResponse).statusCode)")
                }
            }
        }.resume()
    }
}
