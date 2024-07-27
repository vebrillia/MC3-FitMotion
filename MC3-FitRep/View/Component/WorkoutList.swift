
import SwiftUI

struct WorkoutList: View {
    let title: String
    let subtitle: String
    let image: String
    let destination: AnyView
    
    var body: some View {
        NavigationLink(destination: destination) {
            ZStack(alignment: .bottom) {
                VStack {
                    Spacer()
                    HStack {
                        Text(title)
                            .frame(maxHeight: 24)
                            .font(.title2)
                            .bold()
                        Spacer()
                    }
                    
                    HStack {
                        Text(subtitle)
                            .frame(maxHeight: 0)
                            .font(.subheadline)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .frame(maxHeight: 0)
                    }
                    .padding(.bottom, 4)
                }
                .padding()
                .frame(height: 100)
                .background(Color.custTosca)
                .foregroundStyle(Color.fontWhite)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.horizontal)
                
                HStack {
                    Spacer()
                    Image(image)
                        .resizable()
                        .scaledToFill()
                        .shadow(color: Color.fontBlack.opacity(0.2), radius: 0, x: 4, y: 4)
                        .frame(width: 180, height: 110, alignment: .top)
                        .clipped()
                        .padding(.trailing, 40)
                }
            }
        }
    }
}

#Preview {
    WorkoutList(title: "Workout", subtitle: "Subtitle", image: "BicepPerson", destination: AnyView(ContentView()))
}
