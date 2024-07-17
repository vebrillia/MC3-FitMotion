
import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CameraViewController {
        return CameraViewController()
    }
    
    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
        // Update the view controller if needed
    }
    
}
