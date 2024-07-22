
import UIKit
import SwiftUI
import AVFoundation

class CameraViewController: UIViewController {
    
    var videoViewModel: CameraViewModel! = nil
    
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var pointsLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVideoPreview()
        
        videoViewModel.predictor.delegate = self
    }
    
    private func setupVideoPreview() {
        videoViewModel.startCaptureSession()
        previewLayer = AVCaptureVideoPreviewLayer(session: videoViewModel.captureSession)
        
        guard let previewLayer = previewLayer else { return }
        
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = UIScreen.main.bounds
        
        view.layer.addSublayer(previewLayer)
        pointsLayer.frame = view.bounds
        
        pointsLayer.strokeColor = UIColor.custTosca.cgColor
        view.layer.addSublayer(pointsLayer)
    }
}

extension CameraViewController: PredictorDelegate {

    func predictor(_ predictor: Predictor, didFindNewRecognizedPoints points: [CGPoint]) {
        guard let previewLayer = previewLayer else { return }
        
        // convert to preview layer coordinates
        let convertedPoints = points.map {
            previewLayer.layerPointConverted(fromCaptureDevicePoint: $0)
        }
        
        let combinedPath = CGMutablePath()
        
        for point in convertedPoints {
            let dotPath = UIBezierPath(ovalIn: CGRect(x: point.x, y: point.y, width: 10, height: 10))
            combinedPath.addPath(dotPath.cgPath)
        }
        
        // set points layer path so that everytime we get new update, the path updates
        pointsLayer.path = combinedPath
        
        DispatchQueue.main.async {
            self.pointsLayer.didChangeValue(for: \.path)
        }
    }
    
    func predictor(_ predictor: Predictor, didLabelAction action: String, with confidence: Double) {
        videoViewModel.label = action
        videoViewModel.confidence = confidence
    }
}

struct CameraPreview: UIViewControllerRepresentable {
    @Bindable var viewModel: CameraViewModel
    
    func makeUIViewController(context: Context) -> CameraViewController {
        let viewController = CameraViewController()
        viewController.videoViewModel = viewModel
        return viewController
    }
    
    func updateUIViewController(_ viewController: CameraViewController, context: Context) {
    }
}

