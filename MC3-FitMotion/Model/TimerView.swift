//
//  TimerView.swift
//  MC3-FitMotion
//
//  Created by Vebrillia Santoso on 17/07/24.
//

import SwiftUI

struct TimerView: ViewModifier {
    //struct TimerView: View {
    @Binding var isRestTime: Bool //nnti buat statenya sama atur var berubahnya
   
    @State private var offset: CGFloat = 0
    @State private var progress: CGFloat = 1.0
    @State private var timeRemaining = 30
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func body(content: Content) -> some View {
        ZStack{
            content
                .blur(radius: isRestTime ? 10 : 0)
            if isRestTime {
                
                VStack{
                    ZStack {
                        Circle()
                            .stroke(Color("Tosca"), lineWidth: 4)
                            .frame(width: 220, height: 220)
                        
                        Circle()
                            .trim(from: 0, to: progress)
                            .stroke(Color("Orange"), lineWidth: 13)
                            .frame(width: 190, height: 190)
                            .rotationEffect(Angle(degrees: -90))
                            .animation(.linear(duration: 1), value: progress)
                        
                        VStack{
                            Text("Rest for")
                                .foregroundColor(Color("CustGray"))
                                .font(.system(size: 20))
                                .fontWeight(.light)
                            
                            Text("00:\(timeRemaining)")
                                .foregroundColor(Color("CustBlack"))
                                .font(.system(size: 48))
                                .fontWeight(.semibold)
                                .onReceive(timer) { _ in
                                    if timeRemaining > 0 {
                                        timeRemaining -= 1
                                        progress = CGFloat(timeRemaining) / 30.0
                                    } else {
                                        timer.upstream.connect().cancel()
                                    }
                                }
                        }
                    }.padding()
                    
                    Text("Istirahat Antar Set")
                        .padding(.top, 6)
                  .foregroundColor(Color("CustBlack"))
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                    
                    Text("Istirahatkan otot kamu yang baru saja dilatih. Lemaskan dan bersiap untuk set selanjutnya!")
                        .padding(.top,1)
                  .foregroundColor(Color("CustGray"))
                  .multilineTextAlignment(.center)
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .frame(width:250)
                    
                    
                    
                }.frame(width:300,height: 350)
                    .padding()
                    .background(Color("Cream"))
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .offset(y: offset)
                //VStack untuk background only
            }
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

extension View{
    func swipableAlertRest(isRestTime: Binding<Bool>) -> some View {self.modifier(TimerView(isRestTime: isRestTime))
    }
}


struct TimerView_Previews: PreviewProvider {
    @State static var isRestTime = true
    
    static var previews: some View {
        Text("Hello, World!")
            .swipableAlertRest(isRestTime: $isRestTime)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
        

