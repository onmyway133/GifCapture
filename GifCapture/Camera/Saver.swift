//
//  Saver.swift
//  GifCapture
//
//  Created by Khoa Pham on 02/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Foundation
import Regift

class Saver {

  func save(videoUrl: URL, completion: @escaping (URL?) -> Void) {

    Regift.createGIFFromSource(videoUrl,
                               destinationFileURL: gifUrl(),
                               frameCount: Config.shared.frameRate,
                               delayTime: 0, loopCount: 1)
    { [weak self] (url) in
      self?.removeFile(at: videoUrl)
      completion(url)
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
