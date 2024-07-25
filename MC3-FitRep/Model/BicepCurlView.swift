//
//  BicepCurlView.swift
//  MC3-FitMotion
//
//  Created by Baghiz on 24/07/24.
//

import SwiftUI
import Vision

struct BicepCurlView: View {
    
    @State var animatePulse = false
    @State private var bodypose : String = "Idle" //minta info dari camera
    @State private var sizeStatus: Int = 0 //untuk ngambil data berapa ukuran modifier pulse
    
    @ObservedObject var predictionVM = PredictionViewModel()
    @State private var boxColor: Color = .gray.opacity(0.5)
    @StateObject var audioManager = AudioManager()
    @State private var countdown: Int = 5
    @State private var isCountingDown = false
    @State private var timer: Timer?
    @State private var navigateToExerciseView = false
    let boxFrame = CGRect(x: 50, y: 100, width: 300, height: 600)
    
    func startCountdown() {
        isCountingDown = true
        timer?.invalidate()
        countdown = 5 // Reset the countdown value
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

    func resetCountdown() {
        timer?.invalidate()
        countdown = 5
        isCountingDown = false
    }
    
    var pulse : some View {
        ZStack{
            Circle().fill(pulseColor(bodypose).opacity(0.25)).frame(width: 350, height: 350).scaleEffect(self.animatePulse ? 1:0.5)
//                .glow()
            Circle().fill(pulseColor(bodypose).opacity(0.35)).frame(width: 250, height: 250).scaleEffect(self.animatePulse ? 1:0.5)
//                .glow()
            Circle().fill(pulseColor(bodypose).opacity(0.45)).frame(width: 150, height: 150).scaleEffect(self.animatePulse ? 1:0.5)
//                .glow()
            Circle().fill(pulseColor(bodypose)).frame(width: 50, height: 50).scaleEffect(self.animatePulse ? 1:0.5)
//                .glow()
        }.onAppear{
            withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                self.animatePulse.toggle()
                
                if predictionVM.predicted == "Idle"
                {
                    self.animatePulse.toggle()
                    if predictionVM.predicted != "Idle"
                    {self.animatePulse.toggle()}
                }
            }
            bodypose = predictionVM.predicted
        }
    }
    func pulseColor(_ bodypose: String) -> Color { //nanti untuk kirim data dari ML pose bener atau ngga
        if bodypose == "Benar" {
            return Color.green
        } else if bodypose == "Salah" {
            return Color.red
        } else {
            return (Color.gray)
        }
    }
    
    var switchCamera: some View {
        HStack {
            Button {
                predictionVM.videoCapture.toggleCameraSelection()
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath.camera.fill")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            }
            .padding(.leading)
            
            Spacer()
        }
    }
    
    var predictionLabels: some View {
        VStack {
            switchCamera
            pulse
            Spacer()
            Text("Prediction: \(predictionVM.predicted)")
            Text("Confidence: \(predictionVM.confidence)")
            Text("Correct: \(predictionVM.benarCount)")
            Text("Wrong: \(predictionVM.salahCount)")
        }
    }
    
    var StartView: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: boxFrame.width, height: boxFrame.height)
                    .foregroundColor(predictionVM.indicator ? Color.green.opacity(0.3) : boxColor)
                
                if isCountingDown {
                    Text("\(countdown)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                }
            }
            
            Text("Position your body inside the box area until the box turns green.")
                .multilineTextAlignment(.center)
                .padding(10)
                .padding(.top, 20)
        }
        .onChange(of: predictionVM.indicator) { newValue in
            if newValue {
                startCountdown()
            } else {
                resetCountdown()
            }
        }
    }
    
    var body: some View {
        ZStack {
            Image(uiImage: predictionVM.currentFrame ?? UIImage())
                .resizable()
                .scaledToFill()
            
            if navigateToExerciseView {
                predictionLabels
            } else {
                StartView
            }
        }
        .padding()
        .onAppear {
            predictionVM.updateUILabels(with: .startingPrediction)
        }
        // Detect if device change orientation
        .onReceive(
            NotificationCenter
                .default
                .publisher(for: UIDevice.orientationDidChangeNotification)) {
                    _ in
                    predictionVM.videoCapture.updateDeviceOrientation()
                }
    }
}

struct BicepCurlView_Previews: PreviewProvider {
    static var previews: some View {
        BicepCurlView()
    }
}
