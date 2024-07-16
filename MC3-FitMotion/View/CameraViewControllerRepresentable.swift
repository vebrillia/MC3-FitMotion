import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    private var cameraViewModel = CameraViewModel()
    
    func makeUIViewController(context: Context) -> CameraViewController {
        let viewController = CameraViewController()
        viewController.cameraViewModel = cameraViewModel
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) { }
}
