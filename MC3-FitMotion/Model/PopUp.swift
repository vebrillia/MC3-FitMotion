//
//  PopUpGuide.swift
//  MC3-FitMotion
//
//  Created by Citta Catherine Gozali on 15/07/24.
//

import SwiftUI
//https://github.com/SDWebImage/SDWebImageSwiftUI
//import SDWebImageSwiftUI


struct PopUpGuide: ViewModifier {
    @Binding var isPresented: Bool
    @State var buttonAvail: Bool = false
    
    @State private var offset: CGFloat = 0
    @State var selection: Int = 0
    
    
    
    func body(content: Content) -> some View {
        ZStack{
            content
                .blur(radius: isPresented ? 10 : 0)
            
            if isPresented {
                VStack {
                    TabView(selection: $selection) {
                        VStack{
                            Image("Barbell")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                            
                            Text("Berat Beban")
                                .padding (.top, 15)
                                .padding (.bottom, 5)
                                .font(.system(size: 19))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("CustBlack"))
                            
                            Text("Gunakan beban dengan berat yang tepat (tidak terlalu ringan dan tidak terlalu berat) untuk hasil yang maksimal.")
                                .padding (.bottom, 5)
                                .font(.system(size: 15))
                                .fontWeight(.regular)
                                .foregroundColor(Color("CustGray"))
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                        }
                        .tag(0)
                        .padding(.bottom, 20)//Slide 1
                        
                        VStack{
                            Image("Barbell")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                            
                            Text("Berat Beban Terlalu Ringan")
                                .padding (.top, 15)
                                .padding (.bottom, 5)
                                .font(.system(size: 19))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("CustBlack"))
                            
                            Text("Beban **terlalu ringan** jika Anda dapat mengayunkan beban.")
                                .padding (.bottom, 5)
                                .font(.system(size: 15))
                                .fontWeight(.regular)
                                .foregroundColor(Color("CustGray"))
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                        }
                        .tag(1)
                        
                        VStack{
                            Image("Barbell")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                            
                            Text("Berat Beban Terlalu Berat")
                                .padding (.top, 15)
                                .padding (.bottom, 5)
                                .font(.system(size: 19))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("CustBlack"))
                            
                            Text("Beban **terlalu berat** jika Anda tidak dapat menyelesaikan 1 set atau posisi tubuh terasa salah saat mengangkat.")
                                .padding (.bottom, 5)
                                .font(.system(size: 15))
                                .fontWeight(.regular)
                                .foregroundColor(Color("CustGray"))
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                        }
                        .tag(2)
                        
                        VStack{
                            Image("PosisiKamera")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                            
                            Text("Posisi Kamera")
                                .padding (.top, 13)
                                .padding (.bottom, 2)
                                .font(.system(size: 19))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("CustBlack"))
                            
                            Text("Letakkan kamera di posisi yang stabil, boleh dari sudut sejajar ataupun dari bawah. Pastikan seluruh bagian tubuh tertangkap dalam kamera.")
                                .padding (.bottom, 7)
                                .font(.system(size: 15))
                                .fontWeight(.regular)
                                .foregroundColor(Color("CustGray"))
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                        }
                        .tag(3)
                        //End all slides
                        
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode:  .never))
                    .frame(height: 300)
                    .padding(.top,10)
                    .overlay(
                        HStack(spacing: 5){
                            ForEach(Array(arrayLiteral: 0,1,2,3), id: \.self){selected in
                                Capsule()
                                    .fill(selection == selected ? Color("CustGray"):Color("LightGray"))
                                    .frame(width: selection == selected ? 20 : 7, height: 7)
                                    .padding(selection == selected ? 3:0)
                            }
                        }
                        
                        , alignment: .bottom
                    )
                    .onChange(of: selection, {
                        if selection == 3 {
                            buttonAvail = true
                        }
                    })
                    //Tab View Only
                    //------------------------
                    //                    ForEach(Array(arrayLiteral: 0,1,2,3), id: \.self){selected in
                    //                        if selected == 3 {
                    //                            buttonAvail = true
                    //                        }
                    //                    }
                    Button(action: {
                        if buttonAvail{
                            isPresented = false}
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius:10)
                                .frame(width:100,height: 30)
                                .foregroundColor(buttonAvail == false ? (Color("LightGray")) : (Color("Orange")))
                            Text("Start")
                                .foregroundColor(buttonAvail == false ? (Color("CustGray")) : (Color("Cream")))
                                .font(.system(size: 15))
                                .fontWeight(.medium)
                        }
                    }
                    .disabled(!buttonAvail)
                    .padding()//Button End
                    
                }.frame(width:300,height: 350)
                    .padding()
                    .background(Color("Cream"))
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .offset(y: offset)
                //VStack untuk background only
                //ZStack
            }
            
        }
    }//End func body
}//End Struct

extension View{
    func swipableAlert(isPresented: Binding<Bool>) -> some View {self.modifier(PopUpGuide(isPresented: isPresented))
    }
}


struct PopUpGuide_Previews: PreviewProvider {
    @State static var isPresented = true
    
    static var previews: some View {
        Text("Hello, World!")
            .swipableAlert(isPresented: $isPresented)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

//#Preview {
//    ContentView()
//}


//    .onAppear {
//        showAlert = true
//    }
//    .edgesIgnoringSafeArea(.all)
//} .swipableAlert(isPresented: $showAlert)
