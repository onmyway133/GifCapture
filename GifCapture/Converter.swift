//
//  Converter.swift
//  GifCapture
//
//  Created by Khoa Pham on 02/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Foundation
import Regift

struct Converter {

  func convert(videoUrl: URL) {
    Regift.createGIFFromSource(videoUrl, frameCount: 24, delayTime: 0) { (result) in
      print("Gif saved to \(result)")
    }
  }
}
