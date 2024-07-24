//
//  Guidance.swift
//  MC3-FitMotion
//
//  Created by Citta Catherine Gozali on 22/07/24.
//

import SwiftUI
import WebKit

struct GifImageView: UIViewRepresentable {
    private let name: String
    init(_ name: String) {
        self.name = name
    }
    func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
        webview.backgroundColor = .clear
        webview.isOpaque = false
        
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        webview.load(data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: url.deletingLastPathComponent())
        return webview
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
}

struct GuidanceView: View {
    @State var totalset: Int = 3
    @State var totalrep: Int = 12
    @State private var jenisWO: Int = 0
    
    @State var dataInstuksi: [String] = ["1. Pilih beban yang sesuai dengan kemampuanmu.\n2. **Buka kaki selebar bahu, tempel sisi siku ke torso, dan kunci otot perut** dengan berusaha mengecilkan perut semaksimal mungkin.\n3. **Hembuskan nafas saat mengangkat beban dan tarik napas saat menurunkannya**.\n4. Aktifkan otot bisep dan fokuskan kontraksi pada otot tersebut.\n5. Lakukan setiap pergerakan dengan kontrol.\n6. Tempo gerakan: mengangkat 1 detik, menurunkan 2 detik."]//@CHRIS tolong buatkan swift data(?)nya ya thankyou
    @State var dataLarangan: [String] = ["1. Saat memanjangkan lengan, jangan lakukan hingga titik maksimal sendi. Berhenti sedikit sebelum titik maksimal.\n2. Jangan menggerakkan bahu, siku, pergelangan tanga, dan punggung saat melakukan gerakan. Hanya lengan bawah yang boleh bergerak.\n3. Jangan gunakan momentum untuk mengangkat beban."]//DATA
    
    
    var body: some View {
        ZStack (alignment: .bottom){
            Color("Cream").edgesIgnoringSafeArea(.all) //background
            VStack{
                Text("Biceps Curl")
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    .foregroundColor(Color("CustBlack"))
                    .frame(maxWidth:.infinity, alignment: .leading)
                
                
                GifImageView("bodyTutorial")
                    .scaledToFit()
                    .shadow(radius: 5)
                
                Divider()
                    .background(Color.custGray)
                    .frame(height:2)
                    .padding(.top)
                
                ScrollView{
                    HStack{
                        VStack{
                            Text("Target Otot")
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                                .foregroundColor(Color.custBlack)
                                .frame(maxWidth:.infinity, alignment: .leading)
                                .multilineTextAlignment(.leading)
                            Text("Bisep")
                                .font(.system(size: 16))
                                .fontWeight(.regular)
                                .foregroundColor(Color.custGray)
                                .frame(maxWidth:.infinity, alignment: .leading)
                                .multilineTextAlignment(.leading)
                        }.frame(maxWidth:.infinity, alignment: .leading)
                        Spacer()
                            .frame(width:20)
                        VStack{
                            Text("Alat")
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                                .foregroundColor(Color.custBlack)
                                .frame(maxWidth:.infinity, alignment: .leading)
                                .multilineTextAlignment(.leading)
                            Text("Dumbbell")
                                .font(.system(size: 16))
                                .fontWeight(.regular)
                                .foregroundColor(Color.custGray)
                                .frame(maxWidth:.infinity, alignment: .leading)
                                .multilineTextAlignment(.leading)
                        }.frame(maxWidth:.infinity, alignment: .leading)
                        
                    }.frame(maxWidth: .infinity, alignment: .top)//HStack1
                    
                    
                    HStack{
                        VStack(spacing: 0) {
                            Text("Jumlah Set")
                                .font(.system(size: 22))
                                .fontWeight(.semibold)
                                .foregroundColor(Color.custBlack)
                                .frame(maxWidth:.infinity, alignment: .leading)
                                .padding(.bottom,3)
                            HStack {
                                Button(action: {
                                    //Back to beginning
                                }) {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(totalset<=3 ? Color("CustGray") : Color("Orange"))
                                        .overlay(Text("-").foregroundColor(Color("Cream")))
                                        .frame(width:25,height:25)
                                }//Button -
                                
                                TextField("\(totalset)", value: $totalset, format: .number)
                                    .keyboardType(.numberPad)
                                    .font(.system(size: 20))
                                    .fontWeight(.medium)
                                    .frame(width:25, alignment: .center)
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom, 5) // Add some padding at the bottom
                                    .overlay(
                                        Rectangle()
                                            .frame(height: 2) // Height of the underline
                                            .foregroundColor(Color.custGray), // Color of the underline
                                        alignment: .bottom)
                                    .padding(.horizontal,7)
                                
                                Button(action: {
                                    //Back to beginning
                                }) {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(totalset>=5 ? Color("CustGray") : Color("Orange"))
                                        .overlay(Text("+").foregroundColor(Color("Cream")))
                                        .frame(width:25,height:25)
                                }//Button +
                            }.frame(maxWidth:.infinity, alignment: .leading)
                            
                        }
                        
                        VStack (spacing: 0) {
                            Text("Jumlah Rep")
                                .font(.system(size: 22))
                                .fontWeight(.semibold)
                                .foregroundColor(Color.custBlack)
                                .frame(maxWidth:.infinity, alignment: .leading)
                                .padding(.bottom,3)
                            HStack {
                                Button(action: {
                                    //Back to beginning
                                }) {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(totalrep <= 6 ? Color("CustGray") : Color("Orange"))
                                        .overlay(Text("-").foregroundColor(Color("Cream")))
                                        .frame(width:25,height:25)
                                }//Button -
                                
                                TextField("\(totalrep)", value: $totalrep, format: .number)
                                    .keyboardType(.numberPad)
                                    .font(.system(size: 20))
                                    .fontWeight(.medium)
                                    .frame(width:25, alignment: .center)
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom, 5) // Add some padding at the bottom
                                    .overlay(
                                        Rectangle()
                                            .frame(height: 2) // Height of the underline
                                            .foregroundColor(Color.custGray), // Color of the underline
                                        alignment: .bottom)
                                    .padding(.horizontal,7)
                                
                                Button(action: {
                                    //Back to beginning
                                }) {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(totalset>=5 ? Color("CustGray") : Color("Orange"))
                                        .overlay(Text("+").foregroundColor(Color("Cream")))
                                        .frame(width:25,height:25)
                                }//Button +
                            }.frame(maxWidth:.infinity, alignment: .leading)
                            
                        }
                        
                    }.padding(.vertical,10)//HStack Custom Set Rep
                    VStack(spacing:0){
                        Text("Instruksi")
                            .font(.system(size: 22))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.custBlack)
                            .frame(maxWidth:.infinity, alignment: .leading)
                            .padding(.bottom,3)
                        
                        Text(dataInstuksi[jenisWO] ?? "Invalid index")//DATA
                            .font(.system(size: 16))
                            .fontWeight(.light)
                            .foregroundColor(Color.custBlack)
                            .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .leading)
                    }.padding(.vertical,8)
                    VStack (spacing:0){
                        Text("PERHATIAN!")
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                            .foregroundColor(Color("Orange"))
                            .frame(maxWidth:.infinity, alignment: .leading)
                            .padding(.bottom,3)
                        
                        Text(dataInstuksi[jenisWO] ?? "Invalid index")//DATA
                            .font(.system(size: 16))
                            .fontWeight(.light)
                            .foregroundColor(Color.custBlack)
                            .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .leading)
                            .padding(.bottom,5)
                    }.padding(.vertical,8)
                    
                    Rectangle()
                        .fill(Color.custWhite)
                        .frame(height: 50)
                        .edgesIgnoringSafeArea(.bottom)
                }//ScrollView
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(15)//VStack keseluruhan
            
            VStack (spacing: 0) {
                Rectangle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color.custWhite, Color.clear]),
                        startPoint: .bottom,
                        endPoint: .top))
                    .frame(height: 100)
                Rectangle()
                    .fill(Color.custWhite)
                    .frame(height: 50)
                    .edgesIgnoringSafeArea(.bottom)
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()//Ini code untuk shadow
            
            Button(action: {
                //Back to beginning
            }) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("Orange"))
                    .overlay(Text("Mulai").foregroundColor(.white)
                        .font(.system(size: 16))
                        .fontWeight(.medium))
                    .frame(height:40)
                    .frame(maxWidth:.infinity)
                    .padding()
            }
        }//ZStack
    }
}

#Preview {
    GuidanceView()
}
