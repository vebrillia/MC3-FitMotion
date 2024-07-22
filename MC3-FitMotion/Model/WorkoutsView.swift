
import SwiftUI

struct WorkoutsView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationBar(title: "Workouts", subtitle: "Build your muscles!")
                WorkoutList(title: "Bicep Curl", destination: AnyView(PreWorkoutView()))
                WorkoutListLocked(title: "Push Up")
                WorkoutListLocked(title: "Squat")
                Spacer()
            }
            .background(Color.custWhite)
        }
    }
}

#Preview {
    WorkoutsView()
}
