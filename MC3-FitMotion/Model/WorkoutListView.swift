
import SwiftUI

struct WorkoutsView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationBar(title: "Workouts", subtitle: "Build your muscles!")
                
                WorkoutList(title: "Bicep Curl", subtitle: "Arms", image: "BicepPerson3", destination: AnyView(PreWorkoutView()))
                WorkoutListLocked(title: "Push Up", subtitle: "Arms & Chest")
                WorkoutListLocked(title: "Squat", subtitle: "Thighs")
                Spacer()
            }
            .background(Color.custWhite)
            .navigationTitle("Workout List")
            .toolbar(.hidden)
        }
    }
}

#Preview {
    WorkoutsView()
}
