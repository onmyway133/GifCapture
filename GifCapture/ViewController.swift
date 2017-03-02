//
//  ViewController.swift
//  GifCapture
//
//  Created by Khoa Pham on 01/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Cocoa

enum State {
  case record, pause, resume, stop
}

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
      cameraMan = CameraMan(outputUrl: outputUrl(), rect: recordFrame())
      cameraMan?.record()
      recordButton.title = "Pause"
      stopButton.isEnabled = true
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
    }
  }

  // MARK: - Frame

  func recordFrame() -> CGRect {
    guard let window = view.window else {
      return view.frame
    }

    return CGRect(x: window.frame.origin.x,
                  y: window.frame.origin.y + 35,
                  width: view.frame.size.width,
                  height: view.frame.size.height - bottomBox.frame.size.height)
  }

  func outputUrl() -> URL {
    return URL(fileURLWithPath: NSHomeDirectory())
      .appendingPathComponent("/Downloads/file")
      .appendingPathExtension("mov")
  }
}

