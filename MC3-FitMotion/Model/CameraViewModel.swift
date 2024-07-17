
import AVFoundation

class CameraViewModel: NSObject {
    
    var captureSession: AVCaptureSession?
    private var videoInput: AVCaptureDeviceInput?
    private var videoOutput: AVCaptureVideoDataOutput?
    private var videoCaptureDevice: AVCaptureDevice?
    
    override init() {
        super.init()
        setupCaptureSession()
        configureCaptureDevice()
        configureVideoInput()
        configureVideoOutput()
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
}

extension CameraViewModel: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        let videoData = sampleBuffer
        print(videoData)
        print("AAAA")
    }
}
