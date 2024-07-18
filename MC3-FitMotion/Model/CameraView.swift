
import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    @Bindable var viewModel: CameraViewModel
    
    func makeUIViewController(context: Context) -> CameraViewController {
        let viewController = CameraViewController()
        viewController.cameraViewModel = viewModel
        return viewController
    }
    
    func updateUIViewController(_ viewController: CameraViewController, context: Context) {
    }
}
