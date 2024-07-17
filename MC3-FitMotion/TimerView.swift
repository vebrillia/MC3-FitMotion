//
//  TimerView.swift
//  MC3-FitMotion
//
//  Created by Vebrillia Santoso on 17/07/24.
//

import SwiftUI

struct TimerView: View {
    @State private var progress: CGFloat = 1.0
    @State private var timeRemaining = 30
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            ZStack {
                Circle()
                    .stroke(Color(hex: "#50A5AF"), lineWidth: 10)
                    .frame(width: 250, height: 250)
                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(Color(hex: "#F1610D"), lineWidth: 20)
                    .frame(width: 205, height: 205)
                    .rotationEffect(Angle(degrees: -90))
                    .animation(.linear(duration: 1), value: progress)
                
                VStack{
                    Text("Rest for")
                        .font(.title)
                    
                    Text("\(timeRemaining)")
                        .font(.largeTitle)
                        .bold()
                        .onReceive(timer) { _ in
                            if timeRemaining > 0 {
                                timeRemaining -= 1
                                progress = CGFloat(timeRemaining) / 30.0
                            } else {
                                timer.upstream.connect().cancel()
                            }
                        }
                }
            }
            
            Text("Istirahat Antar Set")
                .padding(.top, 20)
                .bold()
            
            Text("Istirahatkan otot kamu yang baru saja dilatih. Lemaskan dan bersiap untuk set selanjutnya!")
                .fontWeight(.thin)
                .padding(.top, 5)
    
            
            
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    TimerView()
}
        

