import AVFoundation
import Combine

class CameraViewModel: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate, ObservableObject {
    typealias Frame = CMSampleBuffer
    typealias FramePublisher = AnyPublisher<Frame, Never>
    
    private var videoOutput: AVCaptureVideoDataOutput?
    private var videoCaptureDevice: AVCaptureDevice?
    private var framePublisher: PassthroughSubject<Frame, Never>?
    
    private let videoCaptureQueue = DispatchQueue(label: "Video Capture Queue", qos: .userInitiated)
    
    @Published var captureSession: AVCaptureSession?
    
    override init() {
        super.init()
        setupCaptureSession()
        configureCaptureDevice()
        configureVideoInput()
        configureVideoOutput()
        createFramePublisher()
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
            let videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            if captureSession.canAddInput(videoInput) {
                captureSession.addInput(videoInput)
            }
        } catch {
            print("Error configuring video input: \(error)")
        }
    }
    
    private func createFramePublisher() {
        let passthroughSubject = PassthroughSubject<Frame, Never>()
        framePublisher = passthroughSubject
    }
    
    
    // MARK: - Configure Video Output
    private func configureVideoOutput() {
        guard let captureSession = captureSession else { return }
        
        videoOutput = AVCaptureVideoDataOutput()
        videoOutput?.setSampleBufferDelegate(self, queue: videoCaptureQueue)
        
        if captureSession.canAddOutput(videoOutput!) {
            captureSession.addOutput(videoOutput!)
        }
        
        videoOutput?.alwaysDiscardsLateVideoFrames = true
    }
}

extension CameraViewModel {
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput frame: Frame,
                       from connection: AVCaptureConnection) {

        print("Frame Sent")
        framePublisher?.send(frame)
    }
}
