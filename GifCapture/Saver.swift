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

  func save(videoUrl: URL, completion: @escaping () -> Void) {

    Regift.createGIFFromSource(videoUrl,
                               destinationFileURL: gifUrl(),
                               frameCount: 30, delayTime: 0, loopCount: 1)
    { [weak self] (url) in
      if let _ = url {
        self?.removeFile(at: videoUrl)
        completion()
      }
    }
  }

  func gifUrl() -> URL {
    let string = Utils.formatter.string(from: Date())
    return Config.outputFolderUrl
      .appendingPathComponent(string)
      .appendingPathExtension("gif")

  }

  func removeFile(at url: URL) {
    try? FileManager.default.removeItem(at: url)
  }
}
