//
//  ContentView.swift
//  MC3-FitMotion
//
//  Created by Citta Catherine Gozali on 14/07/24.
//

import SwiftUI


struct ContentView: View {
    
    @EnvironmentObject var vm: AppViewModel
    
    var body: some View {
        switch vm.dataScannerAccessStatus {
        case .notDetermined:
            Text("Requesting camera access")
        case .cameraAccessNotGranted:
            Text("Please provide access to the camera in settings")
        case .cameraNotAvailable:
            Text("Your device doesn't have a camera")
        case .scannerNotAvailable:
            Text("Your device doesn't support scanning barcode")
        case .scannerAvailable:
            CameraView()
                            .edgesIgnoringSafeArea(.all)
        }
        //        VStack {
        //            Image(systemName: "globe")
        //                .imageScale(.large)
        //                .foregroundStyle(.tint)
        //            Text("Hello, world!")
        //        }
        //        .padding()
    }
}

#Preview {
    ContentView()
}
