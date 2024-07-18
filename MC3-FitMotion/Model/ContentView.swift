//
//  ContentView.swift
//  ActionClassifierSwiftUI
//
//  Created by Kristanto Sean on 18/07/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var cameraViewModel = CameraViewModel()
    @State private var counter = 0
    
    var body: some View {
        ZStack {
            CameraPreview(viewModel: cameraViewModel)
            
            VStack {
                Spacer()
                VStack {
                    Text(cameraViewModel.label)
                    Text("\(cameraViewModel.confidence)")
                    Text("Counter: \(counter)")
                }.padding()
                    .background(.yellow)
            }
            
            SetRepCounterOvl()
        }
        .background(.purple)
        .ignoresSafeArea()
        .onChange(of: cameraViewModel.label) { newLabel in
            if newLabel == "Benar" {
                counter += 1
            }
        }
    }
}

#Preview {
    ContentView()
}
