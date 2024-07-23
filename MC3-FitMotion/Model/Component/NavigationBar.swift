
import SwiftUI

struct NavigationBar: View {
    private let title: String
    private let subtitle: String
    private let image: String
    
    @State private var isShowingPopover = false
    
    init(title: String, subtitle: String, image: String) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .foregroundStyle(Color.custBlack)
                    .font(.largeTitle)
                    .bold()
                Spacer()
                
                Button(action: {
                    self.isShowingPopover.toggle()
                }) {
                    Image(systemName: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.custTosca)
                }
                .popover(isPresented: $isShowingPopover, arrowEdge: .top, content: {
                    Text("Test maseee")
                        .padding()
                        .presentationCompactAdaptation(.popover)
                        .presentationBackgroundInteraction(.enabled)
                })
                .padding(.trailing)
            }
    
            HStack {
                Text(subtitle)
                    .foregroundStyle(Color.custGray)
                Spacer()
            }
        }
        .padding()
    }
}

#Preview {
    NavigationBar(title: "Workouts", subtitle: "Let's workout!", image: "info.circle")
}
