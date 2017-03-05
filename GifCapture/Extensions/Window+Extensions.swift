//
//  Window+Extensions.swift
//  GifCapture
//
//  Created by Khoa Pham on 05/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Cocoa

extension NSWindow {

  func toggleMoving(enabled: Bool) {
    if enabled {
      styleMask.update(with: .resizable)
      isMovable = true
      isMovableByWindowBackground = true
      level = Int(CGWindowLevelForKey(.normalWindow))
    } else {
      styleMask.remove(.resizable)
      isMovable = false
      level = Int(CGWindowLevelForKey(.floatingWindow))
    }
  }
}
