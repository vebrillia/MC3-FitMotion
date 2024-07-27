
import SwiftUI

struct WorkoutListLocked: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        ZStack {
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
                }
                .padding(.bottom, 4)
            }
            .blur(radius: 3)
            
            Image(systemName: "lock.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
        }
        .padding()
        .frame(height: 100)
        .background(Color.custGray)
        .foregroundStyle(Color.fontWhite)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal)
        .frame(height: 100)
    }
}

#Preview {
    WorkoutListLocked(title: "Workout", subtitle: "Subtitle")
}
