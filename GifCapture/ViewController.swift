//
//  ViewController.swift
//  GifCapture
//
//  Created by Khoa Pham on 01/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

  @IBOutlet weak var bottomView: NSView!
  @IBOutlet weak var widthTextField: NSTextField!
  @IBOutlet weak var heightTextField: NSTextField!
  @IBOutlet weak var recordButton: NSButton!
  @IBOutlet weak var stopButton: NSButton!

  var cameraMan: CameraMan?

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  func setup() {
    view.wantsLayer = true
    view.layer?.borderColor = NSColor.lightGray.cgColor
    view.layer?.borderWidth = 2

    bottomView.wantsLayer = true
    bottomView.layer?.backgroundColor = NSColor.lightGray.cgColor

    stopButton.isEnabled = false
  }

  override func viewDidLayout() {
    super.viewDidLayout()

    guard let window = view.window else {
      return
    }

    widthTextField.stringValue = String(format: "%.0f", window.frame.size.width)
    heightTextField.stringValue = String(format: "%.0f", window.frame.size.height)
  }

  // MARK: - Action
  @IBAction func recordButtonTouched(_ sender: NSButton) {
    if cameraMan == nil {
      let outputURL = URL(fileURLWithPath: NSHomeDirectory())
        .appendingPathComponent("/Downloads/file")
        .appendingPathExtension("mov")

      cameraMan = CameraMan(outputURL: outputURL, rect: view.window!.frame)
      cameraMan?.record()
      stopButton.isEnabled = true
    }
  }

  @IBAction func stopButtonTouched(_ sender: NSButton) {
    cameraMan?.stop()
    cameraMan = nil
  }
}

