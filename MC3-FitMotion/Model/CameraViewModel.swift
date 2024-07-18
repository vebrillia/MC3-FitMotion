
import AVFoundation
import Vision

@Observable
class CameraViewModel: NSObject {

    var captureSession: AVCaptureSession?
    private var videoInput: AVCaptureDeviceInput?
    private var videoOutput: AVCaptureVideoDataOutput?
    private var videoCaptureDevice: AVCaptureDevice?
    private var request: VNDetectHumanBodyPoseRequest?
    
    override init() {
        super.init()
        setupCaptureSession()
        configureCaptureDevice()
        configureVideoInput()
        configureVideoOutput()
        setupVisionRequest()
        captureSession?.startRunning()
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
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            if captureSession.canAddInput(videoInput!) {
                captureSession.addInput(videoInput!)
            } else {
                print("Could not add video input to session.")
            }
        } catch {
            print("Error configuring video input: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Configure Video Output
    private func configureVideoOutput() {
        guard let captureSession = captureSession else {
            return
        }
        videoOutput = AVCaptureVideoDataOutput()
        videoOutput?.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        videoOutput?.alwaysDiscardsLateVideoFrames = true
        if captureSession.canAddOutput(videoOutput!) {
            captureSession.addOutput(videoOutput!)
        } else {
            print("Could not add video output to session.")
        }
    }
    
    // MARK: - Setup Vision Request
    private func setupVisionRequest() {
        request = VNDetectHumanBodyPoseRequest()
    }
}

extension CameraViewModel: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        guard let request = request else {
            print("Request is not initialized")
            return
        }

        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        do {
            print("Performing body pose")
            try handler.perform([request])
        } catch {
            print("Failed to perform body pose request: \(error)")
        }
    }
}
