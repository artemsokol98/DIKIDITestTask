//
//  NetworkManager.swift
//  DIKIDITestTask
//
//  Created by Артем Соколовский on 26.12.2022.
//

import Foundation

struct NetworkManager {
    static let shared = NetworkManager()
    
    let apiKey = "https://api-beauty.test.dikidi.ru/home/info?"
    let sessionConfig = URLSessionConfiguration.default
    
    func fetchData(urlString: String, completion: @escaping (Result<Any,Error>) -> Void) {
        //var urlBuilder = URLComponents(string: urlString)
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("maJ9RyT4TJLt7bmvYXU7M3h4F797fUKofUf3373foN94q4peAM", forHTTPHeaderField: "authorization")
        
        sessionConfig.timeoutIntervalForRequest = 30
        let session = URLSession(configuration: sessionConfig)
        
        session.dataTask(with: urlRequest) { data, response, error in
            if let data = data, error == nil {
                if let decodedData = try? JSONDecoder().decode(DataModel.self, from: data) {
                    print(decodedData)
                    completion(.success(decodedData))
                }
            } else {
                guard let error = error else { return }
                print(error)
                completion(.failure(error))
            }
        }.resume()
    }
}
