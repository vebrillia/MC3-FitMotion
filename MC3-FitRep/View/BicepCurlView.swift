//
//  BicepCurlView.swift
//  MC3-FitMotion
//
//  Created by Baghiz on 24/07/24.
//

import SwiftUI
import Vision

struct SemiCircle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: rect.width / 2,
                    startAngle: .degrees(0),
                    endAngle: .degrees(180),
                    clockwise: true)
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        path.closeSubpath()
        return path
    }
}

struct BicepCurlView: View {
    
    @State var animatePulse = false
    @State private var bodypose: Int = 0 //minta info dari camera
    @State private var sizeStatus: Int = 0 //untuk ngambil data berapa ukuran modifier pulse
    @Binding var totalSet: Int
    @Binding var totalRep: Int

    @StateObject var predictionVM = PredictionViewModel()
    @State private var boxColor: Color = .gray.opacity(0.5)
    @StateObject var audioManager = AudioManager()
    @State private var countdown: Int = 5
    @State private var isCountingDown = false
    @State private var timer: Timer?
    @State private var navigateToExerciseView = false
    
    @State var popUpPresented: Bool = true
    
    let boxFrame = CGRect(x: 50, y: 100, width: 325, height: 650)
    
    //move page
    @State var isRestTime: Bool = false
    
    //overlay
    @State var selectedSet: Int = 0
    
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
        ZStack {
            SetRepCounterOverlay(totalset: $totalSet, totalrep: $totalRep, selectedSet: $selectedSet)
            
            VStack {
//                switchCamera
//                    .padding(.top, 10)
                Spacer()
                ZStack {
                    PulseView(predictionVM: predictionVM, animatePulse: $animatePulse, bodypose: $bodypose)
                    
                    VStack {
//                        Text("Prediction: \(predictionVM.predicted)")
//                        Text("Confidence: \(predictionVM.confidence)")
                        Text("\(predictionVM.benarCount)")
                            .font(.system(size: 80))
                            .padding(.bottom,100)
                            .bold()
                            .foregroundColor(.white)
                            .onChange(of:predictionVM.benarCount)
                        {if predictionVM.benarCount == totalRep {
                            isRestTime = true
                            //KASIH CODE UNTUK BERHENTIIN AKTIVITAS CAMERA, nanti kalau isRestTime false jalan lagi dan showrest ikut jadi false.     selectedSet += 1
                            }}
//                        Text("Wrong: \(predictionVM.salahCount)")
                    }
                }
                .offset(y: 175)
                
                
            }
            .onAppear {
                audioManager.playSoundEffect(named: "StartNGuidePertama")
            }
        }
    }//OVERLAY PAS GERAK
    
    var StartView: some View {
        VStack {
//            switchCamera
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: boxFrame.width, height: boxFrame.height)
                    .foregroundColor(predictionVM.indicator ? Color.green.opacity(0.3) : boxColor)
                
                if isCountingDown {
                    VStack {
                        Text("Starting in ")
                        Text("\(countdown)")
                            .font(.system(size: 80))
                    }
                }
            }
            
            Text("Position your body inside the box area until the box turns green.")
                .multilineTextAlignment(.center)
                .padding(.leading, 20)
                .padding(.trailing, 20)
        }
        .onChange(of: predictionVM.indicator) { newValue in
            if newValue {
                startCountdown()
            } else {
                resetCountdown()
            }
        }
    }//OVERLAY ATUR POSISI ORANGNYA
    
    var body: some View {
        ZStack {
            Image(uiImage: predictionVM.currentFrame ?? UIImage())
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            if navigateToExerciseView {
                predictionLabels
                    .fullScreenCover(isPresented: $isRestTime) {
                        ZStack {
                            Color.clear
                                .blur(radius: 2)
                                .ignoresSafeArea(.all)
                            
                            TimerView(isRestTime: $isRestTime)
                                .onAppear {
                                    selectedSet += 1
                                }
                        }
                    }
                    .onChange(of:selectedSet){
                        if selectedSet > 2 {
                            ExerciseDoneView(totalSet: $totalSet, totalRep: $totalRep)
                        }
                    }
            } else {
                StartView
                    
            }
            
        }
        
        .toolbar(.hidden)
        //        .padding()
        .onAppear {
            predictionVM.updateUILabels(with: .startingPrediction)
        }
        .onReceive(
            NotificationCenter
                .default
                .publisher(for: UIDevice.orientationDidChangeNotification)) {
                    _ in
                    predictionVM.videoCapture.updateDeviceOrientation()
                }
        .blur(radius: isRestTime ? 10 : 0)
        .swipableAlert(isPresented: $popUpPresented)
    }//VIEW UTAMA INCLUDE CAMERA
}

struct PulseView: View {
    @ObservedObject var predictionVM: PredictionViewModel
    @Binding var animatePulse: Bool
    @Binding var bodypose: Int
    
    var body: some View {
        ZStack {
            SemiCircle()
                .fill(pulseColor(predictionVM.pulseIndicator).opacity(0.25))
                .frame(width: 350, height: 350)
                .scaleEffect(self.animatePulse ? 1 : 0.5)
            SemiCircle()
                .fill(pulseColor(predictionVM.pulseIndicator).opacity(0.35))
                .frame(width: 250, height: 250)
                .scaleEffect(self.animatePulse ? 1 : 0.5)
            SemiCircle()
                .fill(pulseColor(predictionVM.pulseIndicator).opacity(0.45))
                .frame(width: 150, height: 150)
                .scaleEffect(self.animatePulse ? 1 : 0.5)
            SemiCircle()
                .fill(pulseColor(predictionVM.pulseIndicator))
                .frame(width: 50, height: 50)
                .scaleEffect(self.animatePulse ? 1 : 0.5)
        }
        .blur(radius: 10)
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                self.animatePulse.toggle()
            }
        }
        .onChange(of: predictionVM.predicted) { newValue in
            bodypose = predictionVM.pulseIndicator
        }
    }//PulseCircle
    
    func pulseColor(_ bodypose: Int) -> Color {
        if bodypose == 1 {
            return Color.green
        } else if bodypose == 2 {
            return Color.red
        } else {
            return Color.gray
        }
    }
}//Pulse

#Preview {
    PulseView(predictionVM: PredictionViewModel(), animatePulse: .constant(true), bodypose: .constant(1))
}
