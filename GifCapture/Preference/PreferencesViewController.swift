//
//  PreferencesViewController.swift
//  GifCapture
//
//  Created by Khoa Pham on 05/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Cocoa

class PreferencesViewController: NSViewController {

  @IBOutlet weak var locationTextField: NSTextField!
  @IBOutlet weak var frameRateTextField: NSTextField!

  override func viewWillAppear() {
    super.viewWillAppear()

    locationTextField.stringValue = Config.shared.location
    frameRateTextField.stringValue = "\(Config.shared.frameRate)"
  }

  override func viewDidAppear() {
    super.viewDidAppear()

    view.window?.title = "Preferences"
    _ = view.window?.styleMask.remove(.resizable)
  }

  // MARK: - Action

  @IBAction func okButtonTouched(_ sender: NSButton) {
    checkAndSave()
    view.window?.close()
  }

  // MARK: - Save

  func checkAndSave() {
    if Utils.fileExists(path: locationTextField.stringValue, isDirectory: true) {
      Config.shared.location = locationTextField.stringValue
    }

    if let frameRate = Int(frameRateTextField.stringValue) {
      Config.shared.frameRate = frameRate
    }
  }
}
