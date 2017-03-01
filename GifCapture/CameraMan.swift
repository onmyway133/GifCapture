//
//  CameraMan.swift
//  GifCapture
//
//  Created by Khoa Pham on 01/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Cocoa
import AVFoundation

class CameraMan: NSObject {

  // MARK: - Public

  func record() {
    session.startRunning()
    output.startRecording(toOutputFileURL: outputURL, recordingDelegate: self)
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

  fileprivate let outputURL: URL
  fileprivate let rect: CGRect

  init(outputURL: URL, rect: CGRect) {
    self.outputURL = outputURL
    self.rect = rect

    // Session
    session = AVCaptureSession()
    session.sessionPreset = AVCaptureSessionPresetMedium

    // Input
    input = AVCaptureScreenInput(displayID: CGMainDisplayID())
    input.cropRect = rect
    if session.canAddInput(input) {
      session.addInput(input)
    }

    // Output
    output = AVCaptureMovieFileOutput()
    if session.canAddOutput(output) {
      session.addOutput(output)
    }
  }
}

extension CameraMan: AVCaptureFileOutputRecordingDelegate {

  func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {

  }

  func capture(_ captureOutput: AVCaptureFileOutput!, didPauseRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {

  }

  func capture(_ captureOutput: AVCaptureFileOutput!, didResumeRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {

  }

  func capture(_ captureOutput: AVCaptureFileOutput!, willFinishRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!, error: Error!) {

  }

  func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {

  }
}
