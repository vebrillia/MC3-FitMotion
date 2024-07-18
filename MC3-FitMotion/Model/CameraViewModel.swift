//
//  CameraViewModel.swift
//  ActionClassifierSwiftUI
//
//  Created by Kristanto Sean on 18/07/24.
//

import Foundation
import AVFoundation

@Observable
class CameraViewModel: NSObject {
    
    let captureSession = AVCaptureSession()
    
    let videoOutput = AVCaptureVideoDataOutput()
    
    let predictor = Predictor()
    
    var label = "Label"
    var confidence: Double = 0.0
    
    override init() {
        super.init()
        guard let captureDevice = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: captureDevice) else {
            return
        }

        // set session preset, variable to adjust the quality level of data output
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        captureSession.addInput(input)
        
        captureSession.addOutput(videoOutput)
        
        // to prevent when queue for handling frame is full
        videoOutput.alwaysDiscardsLateVideoFrames = true
    }
    
    func startCaptureSession() {
        captureSession.startRunning()
        
        // setup delegate for when video output returns a frame of video image
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoDispatchQueue"))
    }
}

// handle the delegate for video output
extension CameraViewModel: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        print("FRAME RECEIVED")
        predictor.estimation(sampleBuffer: sampleBuffer)
    }
}
