//
//  Utils.swift
//  GifCapture
//
//  Created by Khoa Pham on 02/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Cocoa

struct Utils {

  static let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH.mm.ss"
    return formatter
  }()

  static func fileExists(path: String, isDirectory: Bool) -> Bool {
    var isDir: ObjCBool = false
    if FileManager.default.fileExists(atPath: path, isDirectory: &isDir) {
      return isDir.boolValue
    }

    return false
  }

  static func constrain(constraints: [NSLayoutConstraint]) {
    constraints.forEach {
      ($0.firstItem as? NSView)?.translatesAutoresizingMaskIntoConstraints = false
      $0.isActive = true
    }
  }
}
