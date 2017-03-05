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

    locationTextField.stringValue = Config.shared.outputFolderUrl.absoluteString
    frameRateTextField.stringValue = "\(Config.shared.frameRate)"
  }

  override func viewDidAppear() {
    super.viewDidAppear()

    view.window?.title = "Preferences"
    _ = view.window?.styleMask.remove(.resizable)
  }

  // MARK: - Action
  @IBAction func okButtonTouched(_ sender: NSButton) {
    view.window?.close()
  }
}
