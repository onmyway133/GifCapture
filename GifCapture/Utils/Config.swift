//
//  Config.swift
//  GifCapture
//
//  Created by Khoa Pham on 04/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Foundation

struct Config {

  enum Keys: String {
    case location
    case frameRate
  }

  static let shared = Config()
  let userDefaults: UserDefaults

  init(userDefaults: UserDefaults = UserDefaults.standard) {
    self.userDefaults = userDefaults
  }

  var outputFolderUrl: URL {
    get {
      let location = userDefaults.url(forKey: Keys.location.rawValue)
      return location ?? URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Downloads")
    }
    set {
      userDefaults.set(newValue, forKey: Keys.location.rawValue)
      userDefaults.synchronize()
    }
  }

  var frameRate: Int {
    get {
      let frameRate = userDefaults.integer(forKey: Keys.frameRate.rawValue)
      return max(min(24, frameRate), 30)
    }
    set {
      userDefaults.set(newValue, forKey: Keys.frameRate.rawValue)
      userDefaults.synchronize()
    }
  }
}
