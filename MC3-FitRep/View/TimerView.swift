//
//  TimerView.swift
//  MC3-FitMotion
//
//  Created by Vebrillia Santoso on 17/07/24.
//

import SwiftUI

struct TimerView: View  {
    //struct TimerView: View {
    @Binding var isRestTime: Bool //nnti buat statenya sama atur var berubahnya
    
    @State private var offset: CGFloat = 0
    @State private var progress: CGFloat = 1.0
    @State private var timeRemaining = 30
    @State var timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    
    
    var body: some View {
        if isRestTime {
            VStack{
                ZStack {
                    Circle()
                        .stroke(Color.custTosca, lineWidth: 4)
                        .frame(width: 220, height: 220)
                    
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(Color.custOrange, lineWidth: 13)
                        .frame(width: 190, height: 190)
                        .rotationEffect(Angle(degrees: -90))
                        .animation(.linear(duration: 1), value: progress)
                    
                    VStack{
                        Text("Rest for")
                            .foregroundColor(Color.custBlack)
                            .font(.system(size: 20))
                            .fontWeight(.light)
                        
                        Text("00:\(timeRemaining)")
                            .foregroundColor(Color.custBlack)
                            .font(.system(size: 48))
                            .fontWeight(.semibold)
                            .onReceive(timer) { _ in
                                if timeRemaining > 0 {
                                    timeRemaining -= 1
                                    progress = CGFloat(timeRemaining) / 30.0
                                } else {
                                    timer.upstream.connect().cancel()
                                    isRestTime = false
                                }
                            }
                    }
                }.padding()
                
                Text("Istirahat Antar Set")
                    .padding(.top, 6)
                    .foregroundColor(Color.custBlack)
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                
                Text("Istirahatkan otot kamu yang baru saja dilatih. Lemaskan dan bersiap untuk set selanjutnya!")
                    .padding(.top,1)
                    .foregroundColor(Color.custGray)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .frame(width:250)
                
                
            }.frame(width:300,height: 350)
                .padding()
                .background(Color.custWhite)
                .cornerRadius(10)
                .shadow(radius: 10)
                .offset(y: offset)
                .onAppear{
                    timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                }
            //VStack untuk background only
        }
    }
}

//extension View{
//    func swipableAlertRest(isRestTime: Binding<Bool>) -> some View {self.modifier(TimerView(isRestTime: isRestTime))
//    }
//}


//struct TimerView_Previews: PreviewProvider {
//    @State static var isRestTime = true
//
//    static var previews: some View {
//        Text("Hello, World!")
//            .swipableAlertRest(isRestTime: $isRestTime)
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
//

