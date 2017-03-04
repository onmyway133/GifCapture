//
//  Config.swift
//  GifCapture
//
//  Created by Khoa Pham on 04/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Foundation

struct Config {

  static var outputFolderUrl: URL = {
    let url: URL = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Downloads")
    return url
  }()
}
