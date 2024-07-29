//
//  PopUpGuide.swift
//  MC3-FitMotion
//
//  Created by Citta Catherine Gozali on 15/07/24.
//

import SwiftUI
import AVFoundation

struct PopUpGuide: ViewModifier {
    @StateObject var audioManager = AudioManager()
    @Binding var isPresented: Bool
    @State var buttonAvail: Bool = false
    
    @State private var offset: CGFloat = 0
    @State var selection: Int = 0
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .blur(radius: isPresented ? 10 : 0)
            
            if isPresented {
                VStack {
                    TabView(selection: $selection) {
                        ForEach(0..<4, id: \.self) { index in
                            VStack {
                                Image(images[index])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                                
                                Text(titles[index])
                                    .padding(.top, 15)
                                    .padding(.bottom, 5)
                                    .font(.system(size: 19))
                                    .foregroundColor(Color.custBlack)
                                
                                Text(descriptions[index])
                                    .padding(.bottom, 5)
                                    .font(.system(size: 15))
                                    .fontWeight(.regular)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity)
                            }
                            .tag(index)
                            .padding(.bottom, 20)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: 300)
                    .padding(.top, 10)
                    .overlay(
                        HStack(spacing: 5) {
                            ForEach(0..<4, id: \.self) { index in
                                Capsule()
                                    .fill(selection == index ? Color.gray : Color.gray.opacity(0.4))
                                    .frame(width: selection == index ? 20 : 7, height: 7)
                                    .padding(selection == index ? 3 : 0)
                            }
                        }
                        , alignment: .bottom
                    )
                    .onChange(of: selection, perform: { value in
                        if value == 3 {
                            buttonAvail = true
                        }
                    })
                    
                    Button(action: {
                        if buttonAvail {
                            isPresented = false
                        }
                        audioManager.playSoundEffect(named: "ArahanKameraAudio")
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 100, height: 30)
                                .foregroundColor(buttonAvail ? Color.custOrange : Color.custGray.opacity(0.5))
                            Text("Start")
                                .foregroundColor(buttonAvail ? Color.fontWhite : Color.custGray)
                        }
                    }
                    .disabled(!buttonAvail)
                    .padding()
                    
                }
                .frame(width: 300, height: 350)
                .padding()
                .background(Color.custWhite)
                .cornerRadius(10)
                .shadow(radius: 10)
                .offset(y: offset)
            }
        }
    }
    
    private var images: [String]{
        return ["Alert", "Weight", "Feather", "PersonFrame"]
    }
    
    private var titles: [String] {
        return ["Berat Beban", "Berat Beban Terlalu Ringan", "Berat Beban Terlalu Berat", "Posisi Kamera"]
    }
    
    private var descriptions: [String] {
        return [
            "Gunakan beban dengan berat yang tepat (tidak terlalu ringan dan tidak terlalu berat) untuk hasil yang maksimal.",
            "Beban 'terlalu ringan' jika Anda dapat mengayunkan beban.",
            "Beban 'terlalu berat' jika Anda tidak dapat menyelesaikan 1 set atau posisi tubuh terasa salah saat mengangkat.",
            "Letakkan kamera di posisi yang stabil, boleh dari sudut sejajar ataupun dari bawah. Pastikan seluruh bagian tubuh tertangkap dalam kamera."
        ]
    }
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
