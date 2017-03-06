//
//  Saver.swift
//  GifCapture
//
//  Created by Khoa Pham on 02/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Foundation
import NSGIF

class Saver {

  typealias Completion = (URL?) -> Void

  func save(videoUrl: URL, completion: @escaping Completion) {

    NSGIF.optimalGIFfromURL(videoUrl, loopCount: 0) { [weak self] (url) in
      self?.copy(url: url, completion: completion)
    }
  }

  func copy(url: URL?, completion: @escaping Completion) {
    guard let url = url else {
      completion(nil)
      return
    }

    defer {
      removeFile(at: url)
    }

    do {
      let gifUrl = self.gifUrl()
      try FileManager.default.copyItem(at: url, to: gifUrl)
      completion(gifUrl)
    } catch {
      completion(nil)
    }
  }

  func gifUrl() -> URL {
    let string = Utils.formatter.string(from: Date())
    return URL(fileURLWithPath: Config.shared.location)
      .appendingPathComponent(string)
      .appendingPathExtension("gif")
  }

  func removeFile(at url: URL) {
    try? FileManager.default.removeItem(at: url)
  }
}
