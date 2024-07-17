import AVFoundation
import UIKit

class CameraViewController: UIViewController {
    let cameraViewModel = CameraViewModel()
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoPreview()
    }
    
    private func setupVideoPreview() {
        previewLayer = AVCaptureVideoPreviewLayer(session: cameraViewModel.captureSession!)
        previewLayer?.frame.size = view.frame.size
        self.view.layer.addSublayer(previewLayer!)
    }
}
