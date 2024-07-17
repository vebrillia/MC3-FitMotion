import UIKit
import SwiftUI
import AVFoundation

class CameraViewController: UIViewController {
    
    private let cameraViewModel = CameraViewModel()
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private var pointsLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPreviewLayer()
        cameraViewModel.classifier.delegate = self
    }
    
    // MARK: - Setup Preview Layer
    private func setupPreviewLayer() {
        guard let captureSession = cameraViewModel.captureSession else { return }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        if let previewLayer = videoPreviewLayer {
            view.layer.addSublayer(previewLayer)
            previewLayer.frame = view.frame
            
            view.layer.addSublayer(pointsLayer)
            pointsLayer.frame = view.frame
            pointsLayer.strokeColor = UIColor.green.cgColor
        }
    }
}

extension CameraViewController: MLClassifierDelegate {
    func predictor(_ predictor: MLClassifier, didLabelAction action: String, with confidence: Double) {
        print("\(action), confidence: \(confidence)")
    }
    
    func predictor(_ predictor: MLClassifier, didFindNewRecognizedPoints points: [CGPoint]) {
        guard let previewLayer = videoPreviewLayer else { return }
        
        let converterPoints = points.map {
            previewLayer.layerPointConverted(fromCaptureDevicePoint: $0)
        }
        
        let combinedPath = CGMutablePath()
        
        for point in converterPoints {
            let dotPath = UIBezierPath(ovalIn: CGRect(x: point.x, y: point.y, width: 10, height: 10))
            combinedPath.addPath(dotPath.cgPath)
        }
        
        pointsLayer.path = combinedPath
        
        DispatchQueue.main.async {
            self.pointsLayer.didChangeValue(for: \.path)
        }
    }
}

struct CameraView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CameraViewController {
       return CameraViewController()
    }
    
    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) { }
}

