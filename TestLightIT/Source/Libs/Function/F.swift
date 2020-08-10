//
//  F.swift
//  TestLightIT
//
//  Created by Анна Яцун on 02.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import Foundation

typealias EventHandler<Event> = (Event) -> ()

func toString(_ class: AnyClass) -> String {
    return String(describing: `class`)
}

public func cast<Value, Result>(_ value: Value) -> Result? {
    return value as? Result
}
