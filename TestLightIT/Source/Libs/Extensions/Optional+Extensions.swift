//
//  File.swift
//  TestLightIT
//
//  Created by Анна Яцун on 02.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import Foundation

extension Optional {

func `do`(_ execute: (Wrapped) -> ()) {
    self.map(execute)
    }
}
