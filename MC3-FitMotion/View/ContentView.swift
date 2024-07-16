//
//  ContentView.swift
//  MC3-FitMotion
//
//  Created by Citta Catherine Gozali on 14/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            CameraView()
                .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    ContentView()
}
