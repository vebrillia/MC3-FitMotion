//
//  ContentView.swift
//  MC3-FitMotion
//
//  Created by Citta Catherine Gozali on 14/07/24.
//

import SwiftUI


struct ContentView: View {
    @State var cameraViewModel = CameraViewModel()
    
    var body: some View {
        CameraView(viewModel: cameraViewModel)
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
