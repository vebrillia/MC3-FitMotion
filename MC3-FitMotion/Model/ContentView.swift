
import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            CameraPreview(viewModel: cameraViewModel)
            
            VStack {
                Spacer()
                VStack {
                    Text(cameraViewModel.label)
                    Text("\(cameraViewModel.confidence)")
                }.padding()
                    .background(.yellow)
            }
        }
        .background(.purple)
        .ignoresSafeArea()
    }
        
}

#Preview {
    ContentView()
}
