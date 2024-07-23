//
//  ExerciseView.swift
//  MC3-FitMotion
//
//  Created by Vebrillia Santoso on 23/07/24.
//

import SwiftUI

struct ExerciseView: View {
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
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: EmptyView())
        .onChange(of: cameraViewModel.label) { newLabel in
            if newLabel == "Benar" {
                counter += 1
            }
        }
        
    }
}

#Preview {
    ExerciseView()
}
