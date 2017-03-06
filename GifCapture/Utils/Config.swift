//
//  Config.swift
//  GifCapture
//
//  Created by Khoa Pham on 04/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Foundation

class Config {

  enum Keys: String {
    case location
    case frameRate
  }

  static let shared = Config()
  let userDefaults: UserDefaults

  init(userDefaults: UserDefaults = UserDefaults.standard) {
    self.userDefaults = userDefaults
  }

  var location: String {
    get {
      let location = userDefaults.string(forKey: Keys.location.rawValue)
      return location ?? NSHomeDirectory().appending("/Downloads")
    }
    set {
      userDefaults.set(newValue, forKey: Keys.location.rawValue)
      userDefaults.synchronize()
    }
  }
}
