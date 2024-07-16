import UIKit
import SwiftUI
import AVFoundation

class CameraViewController: UIViewController {
    var cameraViewModel: CameraViewModel!
    
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPreviewLayer()
    }
    
    // MARK: - Setup Preview Layer
    private func setupPreviewLayer() {
        guard let captureSession = cameraViewModel.captureSession else { return }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = .resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        if let previewLayer = videoPreviewLayer {
            view.layer.addSublayer(previewLayer)
        }
    }
}
