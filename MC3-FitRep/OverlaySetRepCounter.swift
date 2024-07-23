//
//  OverlaySetRepCounter.swift
//  MC3-FitMotion
//
//  Created by Citta Catherine Gozali on 16/07/24.
//

import SwiftUI


//struct OverlaySetRepCounter: ViewModifier {
struct OverlaySetRepCounter: View {//nanti diganti ke viewmodif
    @State var set: Int = 1 //Nanti ada inputnya ini udah set keberapa
    @State var rep: Int = 1 //Nanti ada inputnya ini udah rep keberapa
    
    @State var totalset: Int = 3 //Next iterasi bisa custom total set & rep
    @State var totalrep: Int = 12
    @State var selectedSet: Int = 0
    
    //    func body(content: Content) -> some View {
    var body: some View { //nanti diganti balik
        ZStack{
            //            content
            
            VStack{
                ZStack (alignment: .top){
                    VStack {
                        // Shadow overlay
                        Rectangle()
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [Color.black.opacity(1), Color.clear]),
                                startPoint: .top,
                                endPoint: .bottom))
                            .frame(height: 180)
                            .edgesIgnoringSafeArea(.top)
                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)//Ini code untuk shadow
                    
                    VStack{
                        HStack (spacing:7){
                            ForEach(0..<totalset, id: \.self) { numberSet in
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(selectedSet == numberSet ? .white :Color("CustGray"))
                                    .frame(maxWidth: .infinity, maxHeight: 3)
                            }
                        }.padding(.horizontal)
                            .padding(.bottom, 5)//Ini code untuk garis
                        //                        HStack {
                        //                            Text("**\(rep) of \(totalrep)**\nReps")
                        //                                .frame(maxWidth: .infinity)
                        //                                .multilineTextAlignment(.center)
                        //                                .foregroundColor( Color("Cream"))
                        //                                .font(.system(size: 15))
                        //                                .fontWeight(.semibold)
                        //
                        //                            Spacer()
                        //                                .frame(maxWidth: .infinity )
                        VStack{
                            Text("**\(set) of \(totalset)**")
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                            Text("Sets")
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .font(.system(size: 13))
                                .fontWeight(.regular)
                        }
                        
                        //                        }//Ini code untuk tulisan set rep
                    }//Untuk susun top elements overlay
                    
                    
                }.frame(maxHeight: .infinity)//Untuk top overlay package
                Spacer().frame(maxHeight: .infinity)
                
                //Bottom package ---------------------------
                ZStack (alignment: .bottom){
                    VStack {
                        // Shadow overlay
                        Rectangle()
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [Color.black.opacity(0.8), Color.clear]),
                                startPoint: .bottom,
                                endPoint: .top))
                            .frame(height: 100)
                            .edgesIgnoringSafeArea(.bottom)
                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                        .ignoresSafeArea()//Ini code untuk shadow
                    
                    pulseIndicator()
                        .blur(radius:10)
                    //code Glowing Indicator
                }.frame(maxHeight: .infinity)//Untuk bottom overlay package
                
            }
        }
    }
}


struct pulseIndicator : View {
    @State var animatePulse = false
    @State private var poseStatus: String = "idle"

    var body : some View{
        ZStack{
            Circle().fill(pulseColor(poseStatus).opacity(0.25))
                .frame(width: 350, height: 350).scaleEffect(self.animatePulse ? 1:0)
            Circle().fill(pulseColor(poseStatus).opacity(0.35)).frame(width: 250, height: 250).scaleEffect(self.animatePulse ? 1:0)
            Circle().fill(pulseColor(poseStatus).opacity(0.45)).frame(width: 150, height: 150).scaleEffect(self.animatePulse ? 1:0)
            Circle().fill(pulseColor(poseStatus)).frame(width: 50, height: 50).scaleEffect(self.animatePulse ? 1:0)
        }.onAppear{
            self.animatePulse.toggle()
        }.animation(Animation.linear(duration: 2).repeatCount(2, autoreverses:true))
        
    }
    
    
    func pulseColor(_ poseStatus: String) -> Color { //nanti untuk kirim data dari ML pose bener atau ngga
            if poseStatus == "right" {
                return Color.green
            } else if poseStatus == "wrong" {
                return Color.red
            } else {
                return (Color("CustGray"))
            }
        }
    
}
#Preview {
    OverlaySetRepCounter()
}

//struct Overlay_Previews: PreviewProvider {
//    static var previews: some View {
//        Text("Hello, World!")
//            .swipableAlert(isPresented: $isPresented)
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
