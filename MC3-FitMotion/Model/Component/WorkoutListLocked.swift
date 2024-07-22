
import SwiftUI

struct WorkoutListLocked: View {
    let title: String
    
    var body: some View {
        ZStack {
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
            .blur(radius: 3)
            
            Image(systemName: "lock.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
        }
        .frame(height: 100)
        .background(Color.custGray)
        .foregroundStyle(Color.custWhite)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal)
        .padding(.bottom, 4)
    }
}

#Preview {
    WorkoutListLocked(title: "Workout")
}
