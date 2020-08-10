//
//  APIService.swift
//  TestLightIT
//
//  Created by Анна Яцун on 02.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import Foundation


protocol APIServiceType {
    
    func loginOrRegister(userModel: UserModel,
                         isRegister: Bool,
                         completion: @escaping (Result<TokenModel, Error>) -> ())
    func getCatalog(completion: @escaping (Result<[CatalogModel], Error>) -> ())
    func getComments(id: String,
                     completion: @escaping (Result<[CommentsModel], Error>) -> ())
    func createComments(commentsModel: CommentModel,
                        productId: String,
                        completion: @escaping (Result<TokenModel, Error>) -> ())
}


class APIService: RequestService, APIServiceType {
  
    func loginOrRegister(userModel: UserModel, isRegister: Bool, completion: @escaping (Result<TokenModel, Error>) -> ()) {
        let user = isRegister ? self.urlBuilder.register() : self.urlBuilder.login()
        let data = try? JSONEncoder().encode(userModel)

        user.do {
            var request = URLRequest.init(url: $0)
            request.httpBody = data
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            self.getData(urlRequest: request) { result in
                switch result {
                case let .success(data):
                    let parser = Parser<TokenModel>()
                    completion(parser.object(from: data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getCatalog(completion: @escaping (Result<[CatalogModel], Error>) -> ()) {
        self.urlBuilder.catalog().do {
            self.getData(url: $0) { result in
                switch result {
                case let .success(data):
                    let parser = Parser<[CatalogModel]>()
                    completion(parser.object(from: data))
                case let .failure(error):
                    completion(.failure(error))
                }
                
            }
        }
    }
    
    func getComments(id: String, completion: @escaping (Result<[CommentsModel], Error>) -> ()) {
        self.urlBuilder.comment(productId: id).do {
           self.getData(url: $0) { result in
                switch result {
                case let .success(data):
                    let parser = Parser<[CommentsModel]>()
                    completion(parser.object(from: data))
                case let .failure(error):
                    completion(.failure(error))
                }
                
            }
        }
    }
    
    func createComments(commentsModel: CommentModel, productId: String, completion: @escaping (Result<TokenModel, Error>) -> ()) {
        let user = self.urlBuilder.comment(productId: productId)
        let data = try? JSONEncoder().encode(commentsModel)

        user.do {
            var request = URLRequest.init(url: $0)
            request.httpBody = data
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("Token \(BaseConfigurations().token ?? "")", forHTTPHeaderField: "Authorization")
            self.getData(urlRequest: request) { result in
                switch result {
                case let .success(data):
                    let parser = Parser<TokenModel>()
                    completion(parser.object(from: data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
}
