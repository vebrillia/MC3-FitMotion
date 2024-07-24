//
//  CameraPositionView.swift
//  MC3-FitMotion
//
//  Created by Vebrillia Santoso on 23/07/24.
//

import SwiftUI

struct CameraPositionView: View {
    @ObservedObject var predictionVM = PredictionViewModel()
    
    @StateObject var audioManager = AudioManager()
    @State private var countdown: Int = 5
    @State private var isCountingDown = false
    @State private var timer: Timer?
    @State private var navigateToExerciseView = false
    @State private var boxColor: Color = .gray.opacity(0.5)
    let boxFrame = CGRect(x: 50, y: 100, width: 300, height: 600)
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(uiImage: predictionVM.currentFrame ?? UIImage())
                    .resizable()
                    .scaledToFill()
                
                if isUserInPosition() && isCountingDown{
                    VStack{
                        Text("Starting in ")
                            .padding(.top, -60)
                        
                        Text("\(countdown)")
                            .font(.system(size: 80))
                            .padding(.top,-50)
                    }
                    
                }
    
                
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: boxFrame.width, height: boxFrame.height)
                            .foregroundColor(boxColor)
                    }
                    
                    Text("Position your body inside the box area until the box turns green.")
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .padding(.top, 20)
                    
                    
                }
                
                NavigationLink(destination: PreWorkoutView(), isActive: $navigateToExerciseView) {
                    EmptyView()
                }.navigationBarBackButtonHidden()
            }
            .onChange(of: predictionVM.recognizedPoints) { _ in
                handlePositionChange()
            }
            .onAppear {
                setupTimer()
            }
            .onDisappear {
                timer?.invalidate()
            }
        }
    }
    
    func isUserInPosition() -> Bool {
            for point in predictionVM.recognizedPoints {
                if predictionVM.predicted == "Idle" {
                    return false
                }
            }
            return true
        }

    func handlePositionChange() {
        if isUserInPosition() {
            if !isCountingDown {
                startCountdown()
            }
            boxColor = .green.opacity(0.3)
        } else {
            pauseCountdown()
            boxColor = .gray.opacity(0.5)
        }
    }
    
    func startCountdown() {
            isCountingDown = true
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                if countdown > 1 {
                    countdown -= 1
                    audioManager.playSoundEffect(named: "CountDown1Sec")
                } else {
                    timer?.invalidate()
                    navigateToExerciseView = true
                }
            }
        }
    
    func pauseCountdown() {
        isCountingDown = false
        timer?.invalidate()
    }
    
    func setupTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if isUserInPosition() && isCountingDown {
                if countdown > 1 {
                    countdown -= 1
                } else {
                    timer?.invalidate()
                    navigateToExerciseView = true
                }
            }
        }
    }
}

#Preview {
    CameraPositionView()
}
