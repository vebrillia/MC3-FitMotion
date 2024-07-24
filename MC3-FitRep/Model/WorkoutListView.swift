
import SwiftUI

struct WorkoutsListView: View {
    @State private var path: [Int] = []
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                NavigationBar(title: "Workouts", subtitle: "Build your muscles!", image: "info.circle")
                
                WorkoutList(title: "Bicep Curl", subtitle: "Arms", image: "BicepPerson", destination: AnyView(GuidanceView()))
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
    WorkoutsListView()
}
