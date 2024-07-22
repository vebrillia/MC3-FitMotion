
import SwiftUI

struct NavigationBar: View {
    let title: String
    let subtitle: String
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .foregroundStyle(Color.custBlack)
                    .font(.largeTitle)
                    .bold()
                Spacer()
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
