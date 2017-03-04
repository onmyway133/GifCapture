//
//  State.swift
//  GifCapture
//
//  Created by Khoa Pham on 02/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Foundation

enum State {
  case start
  case record
  case pause
  case resume
  case stop
  case finish(URL?)
  case idle
}
