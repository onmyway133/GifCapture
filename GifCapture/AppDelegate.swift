//
//  AppDelegate.swift
//  GifCapture
//
//  Created by Khoa Pham on 01/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  @IBOutlet weak var recordMenuItem: NSMenuItem!
  @IBOutlet weak var stopMenuItem: NSMenuItem!

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    let window = NSApplication.shared().windows.first!

    // Window
    window.isOpaque = false
    window.backgroundColor = NSColor.clear

    window.contentView?.wantsLayer = true
    window.contentView?.layer?.borderColor = NSColor.gray.cgColor
    window.contentView?.layer?.borderWidth = 2

    window.toggleMoving(enabled: true)

    // Notification
    NSUserNotificationCenter.default.delegate = self
  }

  // MARK: - MenuItem

  @IBAction func helpMenuItemTouched(_ sender: NSMenuItem) {
    let url = URL(string: "https://github.com/onmyway133/GifCapture")!
    NSWorkspace.shared().open(url)
  }
}

extension AppDelegate: NSUserNotificationCenterDelegate {

  func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
    return true
  }
}

