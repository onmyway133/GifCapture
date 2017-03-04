//
//  ViewController.swift
//  GifCapture
//
//  Created by Khoa Pham on 01/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

  @IBOutlet weak var bottomBox: NSBox!
  @IBOutlet weak var widthTextField: NSTextField!
  @IBOutlet weak var heightTextField: NSTextField!
  @IBOutlet weak var recordButton: NSButton!
  @IBOutlet weak var stopButton: NSButton!

  var cameraMan: CameraMan?
  var state: State = .stop {
    didSet {
      handleStatedChanged()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  func setup() {
    stopButton.isEnabled = false
  }

  override func viewDidLayout() {
    super.viewDidLayout()

    let frame = recordFrame()

    widthTextField.stringValue = String(format: "%.0f", frame.size.width)
    heightTextField.stringValue = String(format: "%.0f", frame.size.height)
  }

  // MARK: - Action
  @IBAction func recordButtonTouched(_ sender: NSButton) {
    let mapping: [State: State] = [
      .stop: .record,
      .record: .pause,
      .pause: .resume,
      .resume: .pause
    ]

    if let nextState = mapping[state] {
      state = nextState
    }
  }

  @IBAction func stopButtonTouched(_ sender: NSButton) {
    state = .stop
  }

  // MARK: - State

  func handleStatedChanged() {
    switch state {
    case .record:
      cameraMan = CameraMan(rect: recordFrame())
      cameraMan?.record()
      recordButton.title = "Pause"
      stopButton.isEnabled = true
      toggleWindow(enabled: false)
    case .pause:
      cameraMan?.pause()
      recordButton.title = "Resume"
    case .resume:
      cameraMan?.resume()
      recordButton.title = "Pause"
    case .stop:
      cameraMan?.stop()
      cameraMan = nil
      recordButton.title = "Record"
      stopButton.isEnabled = false
      toggleWindow(enabled: true)
    }
  }

  func toggleWindow(enabled: Bool) {
    guard let window = view.window else {
      return
    }

    if enabled {
      window.styleMask.update(with: .resizable)
      window.isMovable = true
      window.isMovableByWindowBackground = true
      window.level = Int(CGWindowLevelForKey(.normalWindow))
    } else {
      window.styleMask.remove(.resizable)
      window.isMovable = false
      window.level = Int(CGWindowLevelForKey(.floatingWindow))
    }
  }

  // MARK: - Frame

  func recordFrame() -> CGRect {
    guard let window = view.window else {
      return view.frame
    }

    let lineWidth: CGFloat = 2
    let titleHeight: CGFloat = 12
    let someValue: CGFloat = 20

    return CGRect(x: window.frame.origin.x + lineWidth,
                  y: window.frame.origin.y + titleHeight + someValue + lineWidth,
                  width: view.frame.size.width - lineWidth * 2,
                  height: view.frame.size.height - bottomBox.frame.size.height - someValue - lineWidth)
  }
}

