
import SwiftUI

struct ContentView: View {
    @State private var isPopupPresented = true
    var body: some View {
       
        
        ZStack{
            WorkoutsListView()
        }
        .swipableAlert(isPresented: $isPopupPresented)
    }
        
}

#Preview {
    ContentView()
}
