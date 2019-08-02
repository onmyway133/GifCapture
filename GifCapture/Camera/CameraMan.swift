//
//  CameraMan.swift
//  GifCapture
//
//  Created by Khoa Pham on 01/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Cocoa
import AVFoundation

protocol CameraManDelegate: class {
  func cameraMan(man: CameraMan, didChange state: State)
}

class CameraMan: NSObject {

  weak var delegate: CameraManDelegate?

  // MARK: - Public

  func record() {
    let tempVideoUrl = URL(fileURLWithPath: NSTemporaryDirectory())
      .appendingPathComponent(UUID().uuidString)
      .appendingPathExtension("mov")

    session.startRunning()
    output.startRecording(to: tempVideoUrl, recordingDelegate: self)
  }

  func resume() {
    output.resumeRecording()
  }

  func pause() {
    output.pauseRecording()
  }

  func stop() {
    output.stopRecording()
    session.stopRunning()
  }

  // MARK: - Logic

  fileprivate let session: AVCaptureSession
  fileprivate let input: AVCaptureScreenInput
  fileprivate let output: AVCaptureMovieFileOutput

  fileprivate let rect: CGRect

  fileprivate let saver: Saver

  init(rect: CGRect) {
    self.rect = rect

    // Session
    session = AVCaptureSession()
    session.sessionPreset = AVCaptureSession.Preset.high

    // Input
    input = AVCaptureScreenInput(displayID: CGMainDisplayID())!
    input.cropRect = rect
    if session.canAddInput(input) {
      session.addInput(input)
    }

    // Output
    output = AVCaptureMovieFileOutput()
    if session.canAddOutput(output) {
      session.addOutput(output)
    }

    // Saver
    saver = Saver()
  }
}

extension CameraMan: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        delegate?.cameraMan(man: self, didChange: .record)
    }

  func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
    delegate?.cameraMan(man: self, didChange: .stop)

    saver.save(videoUrl: outputFileURL) { [weak self] url in
        guard let strongSelf = self else {
            return
        }

        strongSelf.delegate?.cameraMan(man: strongSelf, didChange: .finish(url))
    }
  }

    func fileOutput(_ output: AVCaptureFileOutput, didPauseRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        delegate?.cameraMan(man: self, didChange: .pause)
    }

    func fileOutput(_ output: AVCaptureFileOutput, didResumeRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        delegate?.cameraMan(man: self, didChange: .resume)
    }
}
