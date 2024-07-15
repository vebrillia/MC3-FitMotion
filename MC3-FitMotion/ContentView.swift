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
            <#code#>
        case .cameraAccessNotGranted:
            <#code#>
        case .cameraNotAvailable:
            Text("Your device doesn't have a camera")
        case .scannerAvailable:
            Text("Scanner is Available")
        case .scannerNotAvailable:
            Text("Your device doesn't support scanning barcode")
        }
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
