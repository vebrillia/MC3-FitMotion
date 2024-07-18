
import AVFoundation
import UIKit
import Vision

class CameraViewController: UIViewController {
    var cameraViewModel = CameraViewModel()
    var previewLayer: AVCaptureVideoPreviewLayer?
    var request: VNDetectHumanBodyPoseRequest?
    
    let drawingLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoPreview()
        configureVision()
        setupDrawingLayer()
        print("View Load")
    }
    
    private func setupVideoPreview() {
        previewLayer = AVCaptureVideoPreviewLayer(session: cameraViewModel.captureSession!)
        previewLayer?.frame.size = view.frame.size
        self.view.layer.addSublayer(previewLayer!)
    }
    
    
    // MARK: - Configure Vision
    private func configureVision() {
        request = VNDetectHumanBodyPoseRequest(completionHandler: bodyPoseHandler)
    }
    
    // MARK: - Handler for detected points
    func bodyPoseHandler(request: VNRequest, error: Error?) {
        print("Handle body pose")
        guard let observations = request.results as? [VNHumanBodyPoseObservation] else { return }
        
        DispatchQueue.main.async {
            self.drawingLayer.sublayers?.forEach { $0.removeFromSuperlayer() }
            print(observations)
            
            print("Observed")
            
            for observation in observations {
                self.processObservation(observation)
            }
        }
    }
    
    
    // MARK: - Setup drawing layer
    func setupDrawingLayer() {
        print("Drawing Layer")
        self.view.layer.addSublayer(drawingLayer)
        drawingLayer.frame = view.frame
        drawingLayer.fillColor = UIColor.red.cgColor
        drawingLayer.lineWidth = 2.0
    }
    
    
    // MARK: - Handler for detected points
    func processObservation(_ observation: VNHumanBodyPoseObservation) {
        do {
            let recognizedPoints = try observation.recognizedPoints(forGroupKey: .all)

            let displayedPoints = recognizedPoints.map {
                CGPoint(x: $0.value.x, y: 1 - $0.value.y)
            }
            
            print("Detected Point")

//            delegate?.predictor(self, didFindNewRecognizedPoints: displayedPoints)
        } catch {
            print("Error finding recognized points: \(error)")
        }
    }
    
    func createDot(at point: CGPoint) -> CAShapeLayer {
        let dotLayer = CAShapeLayer()
        let dotPath = UIBezierPath(arcCenter: point, radius: CGFloat(10), startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        dotLayer.path = dotPath.cgPath
        dotLayer.fillColor = UIColor.green.cgColor
        return dotLayer
    }

    func drawLines(between points: [CGPoint]) {
        guard points.count > 1 else { return }

        let linePath = UIBezierPath()
        for (index, point) in points.enumerated() {
            if index == 0 {
                linePath.move(to: point)
            } else {
                linePath.addLine(to: point)
            }
        }

        let lineLayer = CAShapeLayer()
        lineLayer.path = linePath.cgPath
        lineLayer.fillColor = UIColor.green.cgColor
        lineLayer.lineWidth = CGFloat(10)
        drawingLayer.addSublayer(lineLayer)
    }
}
