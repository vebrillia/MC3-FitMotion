import AVFoundation
import Combine

class CameraViewModel: NSObject {
    private var videoOutput: AVCaptureVideoDataOutput?
    private var videoCaptureDevice: AVCaptureDevice?
    
    let classifier = MLClassifier()
    var captureSession: AVCaptureSession?
    
    override init() {
        super.init()
        setupCaptureSession()
        configureCaptureDevice()
        configureVideoInput()
        configureVideoOutput()
        startCaptureSession()
    }
    
    // MARK: - Setup Capture Session
    private func setupCaptureSession() {
        captureSession = AVCaptureSession()
    }
    
    // MARK: - Configure Capture Device
    private func configureCaptureDevice() {
        videoCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
    }
    
    // MARK: - Configure Video Input
    private func configureVideoInput() {
        guard let captureSession = captureSession, let videoCaptureDevice = videoCaptureDevice else {
            return
        }
        
        do {
            let videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            if captureSession.canAddInput(videoInput) {
                captureSession.addInput(videoInput)
            }
        } catch {
            print("Error configuring video input: \(error)")
        }
    }
    
    // MARK: - Configure Video Output
    private func configureVideoOutput() {
        guard let captureSession = captureSession else { return }
        
        videoOutput = AVCaptureVideoDataOutput()
        
        if captureSession.canAddOutput(videoOutput!) {
            captureSession.addOutput(videoOutput!)
        }
        
        videoOutput?.alwaysDiscardsLateVideoFrames = true
    }
    
    // MARK: - Start Capture Session
    private func startCaptureSession() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession?.startRunning()
        }
        
        videoOutput?.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoDispatchQueue"))
    }
    
}

extension CameraViewModel: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        classifier.estimation(sampleBuffer: sampleBuffer)
    }
}
