//
//  BaseConfigurations.swift
//  TestLightIT
//
//  Created by Анна Яцун on 02.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import Foundation

private struct Constants {

    struct Keys {
        static let user = "BaseConfigurations-user-key"
        static let notifications = "BaseConfigurations-user-notifications"
        static let isCompletedTutorial = "BaseConfigurations-user-isCompletedTutorial"
    }
}

class BaseConfigurations {

    // MARK: -
    // MARK: Variables

    static let `default` = BaseConfigurations()

    var token: String? {
        get {
            UserDefaults.standard.value(forKey: Constants.Keys.isCompletedTutorial) as? String
        }

        set {
            UserDefaults.standard.set(newValue, forKey: Constants.Keys.isCompletedTutorial)
        }
    }
    
    var user: UserDataModel? {
       get {
              let userValue = UserDefaults.standard.value(forKey: Constants.Keys.user) as? Data

              return userValue.flatMap {
                  let encoder = JSONDecoder()
                  return try? encoder.decode(UserDataModel.self, from: $0)
              }
          }

          set {
              let encoder = JSONEncoder()
              let encoded = try? encoder.encode(newValue)
              UserDefaults.standard.set(encoded, forKey: Constants.Keys.user)
          }
      }
}
