//
//  BicepCurl.swift
//  MC3-FitMotion
//
//  Created by Baghiz on 23/07/24.
//

import SwiftUI
import Vision

struct BicepCurlView: View {
    
    @ObservedObject var predictionVM = PredictionViewModel()
    
    
    var predictionLabels: some View {
        VStack {
            Spacer()
            Text("Prediction: \(predictionVM.predicted)")
            Text("Confidence: \(predictionVM.confidence)")
            Text("Correct: \(predictionVM.benarCount)")
            Text("Wrong: \(predictionVM.salahCount)")
        }
    }
    
    var body: some View {
        ZStack {
            Image(uiImage: predictionVM.currentFrame ?? UIImage())
                .resizable()
                .scaledToFill()
            
            predictionLabels
        }
        .padding()
        .onAppear{
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
