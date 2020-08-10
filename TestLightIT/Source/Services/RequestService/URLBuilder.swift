//
//  URLBuilder.swift
//  TestLightIT
//
//  Created by Анна Яцун on 07.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import Foundation

class URLBuilder {
   
    let apiUrl = "http://smktesting.herokuapp.com/"
    
    func register() -> URL? {
        return URL(string: apiUrl + "api/register/")
    }
    
    func login() -> URL? {
        return URL(string: apiUrl + "api/login/")
    }
    
    func catalog() -> URL? {
        return URL(string: apiUrl + "api/products/")
    }
    
    func comment(productId: String) -> URL? {
        return URL(string: apiUrl + "api/reviews/" + productId)
    }

}
