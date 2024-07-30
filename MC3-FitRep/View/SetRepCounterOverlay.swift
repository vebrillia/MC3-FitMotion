//
//  OverlaySetRepCounter.swift
//  MC3-FitMotion
//
//  Created by Citta Catherine Gozali on 16/07/24.
//

import SwiftUI


struct SetRepCounterOverlay: View {//nanti diganti ke viewmodif
    @State var set: Int = 1 //Nanti ada inputnya ini udah set keberapa
    @State var rep: Int = 1 //Nanti ada inputnya ini udah rep keberapa
    
    @Binding var totalset: Int
    @Binding var totalrep: Int
    @Binding var selectedSet: Int
    

    var body: some View {
        ZStack{
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
                        Spacer ()
                            .frame(height:10)
                        HStack (spacing:7){
                            ForEach(0..<totalset, id: \.self) { numberSet in
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(selectedSet == numberSet ? .white :Color.custGray)
                                    .frame(maxWidth: .infinity, maxHeight: 3)
                            }
                        }.padding(.horizontal)
                            .padding(.bottom, 5)//Ini code untuk garis
                        
                        VStack{
                            Text("**\(selectedSet+1) of \(totalset)**")
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .font(.system(size: 28))
                                .fontWeight(.semibold)
                            Text("Sets")
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .font(.system(size: 20))
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
                    
//                    pulseIndicator()
                        .blur(radius:5)
                    //code Glowing Indicator
                }.frame(maxHeight: .infinity)//Untuk bottom overlay package
                
            }
        }
    }
}


#Preview {
    SetRepCounterOverlay(totalset: .constant(3), totalrep: .constant(12), selectedSet: .constant(0))
}
