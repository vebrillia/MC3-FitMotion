
import SwiftUI

struct WorkoutList: View {
    let title: String
    let destination: AnyView
    
    var body: some View {
        NavigationLink(destination: self.destination) {
            VStack {
                Spacer()
                HStack {
                    Text(title)
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding()
            }
            .frame(height: 100)
            .background(Color.custTosca)
            .foregroundStyle(Color.custWhite)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal)
            .padding(.bottom, 4)
        }
    }
}

#Preview {
    WorkoutList(title: "Workout", destination: AnyView(ContentView()))
}
