//
//  CameraView.swift
//  MC3-FitMotion
//
//  Created by Vebrillia Santoso on 15/07/24.
//

import UIKit
import SwiftUI
import AVFoundation

class CameraViewController: UIViewController {
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var videoInput: AVCaptureDeviceInput?
    var videoOutput: AVCaptureVideoDataOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession()
        configureVideoInput()
        configureVideoOutput()
        setupPreviewLayer()
        
        captureSession?.startRunning()
    }
    
    // MARK: - Setup Capture Session
    private func setupCaptureSession() {
        captureSession = AVCaptureSession()
    }
    
    // MARK: - Configure Video Input
    private func configureVideoInput() {
        guard let captureSession = captureSession,
              let videoCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            return
        }
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            if captureSession.canAddInput(videoInput!) {
                captureSession.addInput(videoInput!)
            }
        } catch {
            print("Error configuring video input: \(error)")
            return
        }
    }
    
    // MARK: - Configure Video Output
    private func configureVideoOutput() {
        guard let captureSession = captureSession else { return }
        
        videoOutput = AVCaptureVideoDataOutput()
        if captureSession.canAddOutput(videoOutput!) {
            captureSession.addOutput(videoOutput!)
        }
    }
    
    // MARK: - Setup Preview Layer
    private func setupPreviewLayer() {
        guard let captureSession = captureSession else { return }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = .resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        if let previewLayer = videoPreviewLayer {
            view.layer.addSublayer(previewLayer)
        }
    }
}


struct CameraView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> CameraViewController {
        return CameraViewController()
    }
    
    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
        // Update the view controller if needed
    }
}
