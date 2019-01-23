//
//  MainViewController.swift
//  GifCapture
//
//  Created by Khoa Pham on 01/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {

  @IBOutlet weak var bottomBox: NSBox!
  @IBOutlet weak var widthTextField: NSTextField!
  @IBOutlet weak var heightTextField: NSTextField!
  @IBOutlet weak var recordButton: NSButton!
  @IBOutlet weak var stopButton: NSButton!
  var loadingIndicator: LoadingIndicator!

  var cameraMan: CameraMan?
  var state: State = .idle {
    didSet {
      DispatchQueue.main.async {
        self.handleStateChanged()
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  func setup() {
    stopButton.isEnabled = false

    loadingIndicator = LoadingIndicator()
    view.addSubview(loadingIndicator)
    Utils.constrain(constraints: [
      loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      loadingIndicator.widthAnchor.constraint(equalToConstant: 100),
      loadingIndicator.heightAnchor.constraint(equalToConstant: 100)
    ])
    
    loadingIndicator.hide()
  }

  override func viewDidLayout() {
    super.viewDidLayout()

    let size = scaleFactorRecordSize()

    widthTextField.stringValue = String(format: "%.0f", size.width)
    heightTextField.stringValue = String(format: "%.0f", size.height)
  }

  // MARK: - Action
  @IBAction func recordButtonTouched(_ sender: NSButton) {
    if case .idle = state {
      state = .start
    } else if case .pause = state{
      cameraMan?.resume()
    } else if case .record = state {
      cameraMan?.pause()
    } else if case .resume = state {
      cameraMan?.pause()
    }
  }

  @IBAction func stopButtonTouched(_ sender: NSButton) {
    cameraMan?.stop()
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

  func scaleFactorRecordSize() -> CGSize {
    let frame = recordFrame()
    let scale = view.window?.screen?.backingScaleFactor ?? 2.0

    return CGSize(width: frame.size.width * scale,
                  height: frame.size.height * scale)
  }

  // MARK: - State

  func handleStateChanged() {
    switch state {
    case .start:
      cameraMan = CameraMan(rect: recordFrame())
      cameraMan?.delegate = self
      cameraMan?.record()
    case .record:
      recordButton.title = "Pause"
      toggleStopButton(enabled: true)
      view.window?.toggleMoving(enabled: false)
    case .pause:
      recordButton.title = "Resume"
    case .resume:
      recordButton.title = "Pause"
    case .stop:
      toggleRecordButton(enabled: false)
      toggleStopButton(enabled: false)
      loadingIndicator.show()
    case .finish(let url):
      if let url = url {
        showNotification(url: url)
      } else {

      }
      state = .idle
    case .idle:
      cameraMan = nil
      recordButton.title = "Record"
      toggleStopButton(enabled: false)
      toggleRecordButton(enabled: true)
      loadingIndicator.hide()
      view.window?.toggleMoving(enabled: true)
    }
  }

  // MARK: - Notification

  func showNotification(url: URL) {
    let notification = NSUserNotification()
    notification.title = "GifCapture 🏇"
    notification.informativeText = url.absoluteString
    notification.hasActionButton = true
    notification.actionButtonTitle = "Open"

    NSUserNotificationCenter.default.deliver(notification)
  }

  // MARK: - Menu Item

  func toggleRecordButton(enabled: Bool) {
    recordButton.isEnabled = enabled
    (NSApplication.shared.delegate as! AppDelegate).recordMenuItem.isEnabled = enabled
  }

  func toggleStopButton(enabled: Bool) {
    stopButton.isEnabled = enabled
    (NSApplication.shared.delegate as! AppDelegate).stopMenuItem.isEnabled = enabled
  }

  @IBAction func recordMenuItemTouched(_ sender: NSMenuItem) {
    if case .idle = state {
      state = .start
    }
  }

  @IBAction func stopMenuItemTouched(_ sender: NSMenuItem) {
    cameraMan?.stop()
  }
}

extension MainViewController: CameraManDelegate {

  func cameraMan(man: CameraMan, didChange state: State) {
    self.state = state
  }
}

