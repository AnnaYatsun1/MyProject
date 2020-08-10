//
//  NetworkService.swift
//  TestLightIT
//
//  Created by Анна Яцун on 02.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import Foundation

import Foundation
import Reachability


protocol NetworkServiceType {
    var isReachableDidChanged: EventHandler<Bool>? { get set }
    var isReachable: Bool { get }
}


class NetworkService: NetworkServiceType {
        
    var isReachableDidChanged: EventHandler<Bool>? = nil
    
    let reachbility = try? Reachability()
    
    var isReachable = true {
        didSet {
            self.isReachableDidChanged?(self.isReachable)
        }
    }
    
    init() {
        self.start()
    }
    
    private func start() {
        self.isReachable = self.reachbility?.connection != .some(.unavailable)
        
        self.reachbility?.whenReachable = { value in
            self.isReachable = true
        }
        
        self.reachbility?.whenUnreachable = { value in
            self.isReachable = false
        }
    }
}
