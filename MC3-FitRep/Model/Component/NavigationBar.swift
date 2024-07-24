
import SwiftUI

struct NavigationBar: View {
    private let title: String
    private let subtitle: String
    private let rightButton: AnyView?
    private let leftButton: AnyView?
    
    @State private var isShowingPopover = false
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
    
    var body: some View {
        VStack {
            
            HStack {
                
            }
            
            HStack {
                Text(title)
                    .frame(height: 32)
                    .foregroundStyle(Color.custBlack)
                    .font(.largeTitle)
                    .bold()
                Spacer()
            }
    
            HStack {
                Text(subtitle)
                    .foregroundStyle(Color.custGray)
                    .frame(height: 8)
                Spacer()
            }
        }
        .padding()
    }
}

#Preview {
    NavigationBar(title: "Workouts", subtitle: "Let's workout!", image: "info.circle")
}
