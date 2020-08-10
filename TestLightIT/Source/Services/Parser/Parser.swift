//
//  Parser.swift
//  TestLightIT
//
//  Created by Анна Яцун on 02.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import Foundation

enum ParserErrors: Error {
    
    case dataError
}

class Parser<Object: Decodable> {
    
    func object(from data: Data?) -> Result<Object, Error> {
        return data
            .flatMap {
                try? JSONDecoder().decode(Object.self, from: $0)
            }
            .map {
                .success($0)
            }
            ?? .failure(ParserErrors.dataError)
    }
}

