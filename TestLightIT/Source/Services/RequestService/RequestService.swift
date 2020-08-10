//
//  RequestService.swift
//  TestLightIT
//
//  Created by Анна Яцун on 02.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import UIKit

class RequestService {
    
    let session: URLSession
    let urlBuilder: URLBuilder
    
    init(session: URLSession, urlBuilder: URLBuilder) {
        self.session = session
        self.urlBuilder = urlBuilder
    }
    
    func getData(url: URL, completion: @escaping (Result<Data, Error>) -> ()) {
        let task = self.session.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
    
    func getData(urlRequest: URLRequest, completion: @escaping (Result<Data, Error>) -> ()) {
          let task = self.session.dataTask(with: urlRequest) { data, response , error in
                print(response)
              if let error = error {
                  completion(.failure(error))
              }
              if let data = data {
                  completion(.success(data))
              }
          }
          task.resume()
      }
}

    