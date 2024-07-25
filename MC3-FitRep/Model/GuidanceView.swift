//
//  Guidance.swift
//  MC3-FitMotion
//
//  Created by Citta Catherine Gozali on 22/07/24.
//

import SwiftUI
import WebKit


struct GuidanceView: View {
    let selectedWorkout = "Bicep Curl"
    
    @State var totalSet: Int = 3
    @State var totalRep: Int = 12
    
    @State var dataInstuksi: String = "1. Pilih beban yang sesuai dengan kemampuanmu.\n2. **Buka kaki selebar bahu, tempel sisi siku ke torso, dan kunci otot perut** dengan berusaha mengecilkan perut semaksimal mungkin.\n3. **Hembuskan nafas saat mengangkat beban dan tarik napas saat menurunkannya**.\n4. Aktifkan otot bisep dan fokuskan kontraksi pada otot tersebut.\n5. Lakukan setiap pergerakan dengan kontrol.\n6. Tempo gerakan: mengangkat 1 detik, menurunkan 2 detik."//@CHRIS tolong buatkan swift data(?)nya ya thankyou
    @State var dataLarangan: String = "1. Saat memanjangkan lengan, jangan lakukan hingga titik maksimal sendi. Berhenti sedikit sebelum titik maksimal.\n2. Jangan menggerakkan bahu, siku, pergelangan tanga, dan punggung saat melakukan gerakan. Hanya lengan bawah yang boleh bergerak.\n3. Jangan gunakan momentum untuk mengangkat beban."//DATA
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.custBlack]
    }
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                
                Color.custWhite
                    .ignoresSafeArea(.all)
                
                ScrollView {
//                    GIFImageView("bodyTutorial")
//                        .scaledToFit()
//                        .frame(maxWidth: .infinity, maxHeight: 260)
//                        .background(Color.custTosca)
                    
                    AnimatedImage(imageName: "bodyTutorial", totalFrame: 86, frameDuration: 0.03, zeroPadding: 4)
                        .frame(maxWidth: .infinity, maxHeight: 260)
                        .background(Color.custTosca)
                    
                    HStack(spacing: 60) {
                        VStack {
                            Text("Target Otot")
                                .frame(maxWidth:.infinity, alignment: .leading)
                                .foregroundColor(Color.custBlack)
                                .font(.title3)
                                .bold()
                            
                            Text("Biceps")
                                .frame(maxWidth:.infinity, alignment: .leading)
                                .foregroundColor(Color.custGray)
                        }
                        
                        VStack {
                            Text("Peralatan")
                                .frame(maxWidth:.infinity, alignment: .leading)
                                .foregroundColor(Color.custBlack)
                                .font(.title3)
                                .bold()
                            
                            Text("Dumbbell")
                                .frame(maxWidth:.infinity, alignment: .leading)
                                .foregroundColor(Color.custGray)
                        }
                    }
                    .padding()
                    
                    HStack(spacing: 60) {
                        VStack {
                            Text("Jumlah Set")
                                .frame(maxWidth:.infinity, alignment: .leading)
                                .foregroundColor(Color.custBlack)
                                .font(.title3)
                                .bold()
                            
                            HStack {
                                Button(action: {
                                    self.totalSet -= 1
                                }) {
                                    Text("-")
                                        .foregroundStyle(Color.custWhite)
                                }
                                .frame(width: 25, height: 25)
                                .background(totalSet <= 3 ? Color.custGray : Color.custOrange)
                                .disabled(totalSet <= 3)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                
                                TextField("\(totalSet)", value: $totalSet, format: .number)
                                    .keyboardType(.numberPad)
                                    .frame(width: 25)
                                    .multilineTextAlignment(.center)
                                    .padding(3)
                                    .overlay(
                                        Rectangle()
                                            .frame(height: 1)
                                            .foregroundColor(Color.custGray),
                                        alignment: .bottom)
                                
                                Button(action: {
                                    self.totalSet += 1
                                }) {
                                    Text("+")
                                        .foregroundStyle(Color.custWhite)
                                }
                                .frame(width: 25, height: 25)
                                .background(totalSet >= 6 ? Color.custGray : Color.custOrange)
                                .disabled(totalSet >= 6)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                
                                Spacer()
                            }
                        }
                        
                        VStack {
                            Text("Jumlah Rep")
                                .frame(maxWidth:.infinity, alignment: .leading)
                                .foregroundColor(Color.custBlack)
                                .font(.title3)
                                .bold()
                            
                            HStack {
                                Button(action: {
                                    self.totalRep -= 1
                                }) {
                                    Text("-")
                                        .foregroundStyle(Color.custWhite)
                                }
                                .frame(width: 25, height: 25)
                                .background(totalRep <= 6 ? Color.custGray : Color.custOrange)
                                .disabled(totalRep <= 6)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                
                                TextField("\(totalRep)", value: $totalRep, format: .number)
                                    .keyboardType(.numberPad)
                                    .frame(width: 25)
                                    .multilineTextAlignment(.center)
                                    .padding(3)
                                    .overlay(
                                        Rectangle()
                                            .frame(height: 1)
                                            .foregroundColor(Color.custGray),
                                        alignment: .bottom)
                                
                                Button(action: {
                                    self.totalRep += 1
                                }) {
                                    Text("+")
                                        .foregroundStyle(Color.custWhite)
                                }
                                .frame(width: 25, height: 25)
                                .background(totalRep >= 15 ? Color.custGray : Color.custOrange)
                                .disabled(totalRep >= 15)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    VStack {
                        Text("Instruksi")
                            .foregroundColor(Color.custBlack)
                            .font(.title2)
                            .bold()
                            .frame(maxWidth:.infinity, alignment: .leading)
                        
                        Text(dataInstuksi)
                            .foregroundColor(Color.custBlack)
                            .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .leading)
                    }
                    .padding()
                    
                    VStack {
                       Text("PERHATIAN!")
                            .foregroundColor(Color.custOrange)
                            .font(.title2)
                            .bold()
                            .frame(maxWidth:.infinity, alignment: .leading)

                       Text(dataInstuksi)
                            .foregroundColor(Color.custBlack)
                            .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .leading)
                   }
                    .padding(.horizontal)
                }
            }
            .navigationTitle(selectedWorkout)
        }
    }
}

#Preview {
    GuidanceView()
}
