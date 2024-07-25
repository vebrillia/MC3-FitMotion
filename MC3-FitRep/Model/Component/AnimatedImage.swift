import SwiftUI

struct AnimatedImage: View {
    @State private var currentFrame = 0
    var imageName: String
    var totalFrame: Int
    var frameDuration: Double
    var zeroPadding: Int
    
    var body: some View {
        Image("\(imageName)\(String(format: "%0\(zeroPadding)d", currentFrame))")
            .resizable()
            .scaledToFit()
            .onReceive(Timer.publish(every: frameDuration, on: .main, in: .common).autoconnect()) { _ in
                if currentFrame == totalFrame {
                    currentFrame = 0
                } else {
                    currentFrame += 1
                }
            }
    }
}

#Preview {
    AnimatedImage(imageName: "bodyTutorial", totalFrame: 86, frameDuration: 0.03, zeroPadding: 4)
}
