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
    @State private var isPopupPresented = true
    
    var body: some View {
        ZStack {
            CameraPreview(viewModel: cameraViewModel)
                .ignoresSafeArea(.all)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Spacer()
                VStack {
//                    Text(cameraViewModel.label)
//                    Text("\(cameraViewModel.confidence)")
                    Text("\(counter)")
                        .bold()
                        .font(.system(size: 80))
                        .padding(.bottom, -18)
                    
                    Text("Reps")
                        
                }.padding()
                    
            }
            
            pulseIndicator()
                
            
            SetRepCounterOvl()
            
        }
        
        .onChange(of: cameraViewModel.label) { newLabel in
            if newLabel == "Benar" {
                counter += 1
            }
        }
        .swipableAlert(isPresented: $isPopupPresented)
    }
}

#Preview {
    ContentView()
}
