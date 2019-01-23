//
//  LoadingIndicator.swift
//  GifCapture
//
//  Created by Khoa Pham on 06/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Cocoa

class LoadingIndicator: NSBox {

  var progressIndicator: NSProgressIndicator!

  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)

    boxType = .custom
    title = ""
    fillColor = NSColor.white.withAlphaComponent(0.5)
    cornerRadius = 5
    borderType = .noBorder

    progressIndicator = NSProgressIndicator()
    progressIndicator.style = .spinning
    progressIndicator.isDisplayedWhenStopped = false
    progressIndicator.startAnimation(nil)

    addSubview(progressIndicator)

    Utils.constrain(constraints: [
      progressIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
      progressIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  func show() {
    alphaValue = 1.0
  }

  func hide() {
    alphaValue = 0
  }
}
