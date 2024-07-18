//
//  ContentView.swift
//  ActionClassifierSwiftUI
//
//  Created by Kristanto Sean on 18/07/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var cameraViewModel = CameraViewModel()
    
    var body: some View {
        ZStack {
            CameraPreview(viewModel: cameraViewModel)
            
            VStack {
                Spacer()
                VStack {
                    Text(cameraViewModel.label)
                    Text("\(cameraViewModel.confidence)")
                }.padding()
                    .background(.yellow)
            }
        }
        .background(.purple)
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
