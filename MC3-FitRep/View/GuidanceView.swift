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
    
    @State var dataInstuksi: String = """
    1. Pilih beban yang sesuai dengan kemampuanmu.
    2. Buka kaki selebar bahu, tempel sisi siku ke torso, dan kunci otot perut dengan berusaha mengecilkan perut semaksimal mungkin.
    3. Hembuskan nafas saat mengangkat beban dan tarik napas saat menurunkannya.
    4. Aktifkan otot bisep dan fokuskan kontraksi pada otot tersebut.
    5. Lakukan setiap pergerakan dengan kontrol.
    6. Tempo gerakan: mengangkat 1 detik, menurunkan 2 detik.
    """

    @State var dataLarangan: String = """
    1. Saat memanjangkan lengan, jangan lakukan hingga titik maksimal sendi. Berhenti sedikit sebelum titik maksimal.
    2. Jangan menggerakkan bahu, siku, pergelangan tangan, dan punggung saat melakukan gerakan. Hanya lengan bawah yang boleh bergerak.
    3. Jangan gunakan momentum untuk mengangkat beban.
    """
    
    @State var isCameraViewShowing: Bool = false

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.custBlack]
    }
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                
                Color.custWhite
                    .ignoresSafeArea(.all)
                
                ScrollView {
                    
                    AnimatedImage(imageName: "bodyTutorialpng", totalFrame: 86, frameDuration: 0.03, zeroPadding: 4)
                        .frame(maxWidth: .infinity, maxHeight: 260)
                        .background(Color.custTosca)
                    
                    HStack(spacing: 60) {
                        VStack {
                            Text("Target Otot")
                                .frame(maxWidth:.infinity, alignment: .leading)
                                .font(.title3)
                                .bold()
                            
                            Text("Biceps")
                                .frame(maxWidth:.infinity, alignment: .leading)
                                .foregroundColor(Color.custGray)
                        }
                        
                        VStack {
                            Text("Peralatan")
                                .frame(maxWidth:.infinity, alignment: .leading)
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
                                .font(.title2)
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
                                .font(.title2)
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
                            .font(.title2)
                            .bold()
                            .frame(maxWidth:.infinity, alignment: .leading)
                            .padding(.bottom, 6)
                        
                        VStack(alignment: .leading) {
                            ForEach(dataInstuksi.components(separatedBy: "\n"), id: \.self) { line in
                                HStack(alignment: .top) {
                                    Text(line.prefix(3))
                                        .padding(.leading, 6)
                                    
                                    Text(line.dropFirst(3))
                                        .tracking(0.5)
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding()
                    
                    VStack {
                       Text("Perhatian")
                            .font(.title2)
                            .bold()
                            .frame(maxWidth:.infinity, alignment: .leading)
                            .padding(.bottom, 6)

                        VStack(alignment: .leading) {
                            ForEach(dataLarangan.components(separatedBy: "\n"), id: \.self) { line in
                                HStack(alignment: .top) {
                                    Text(line.prefix(3))
                                        .padding(.leading, 6)
                                    
                                    Text(line.dropFirst(3))
                                        .tracking(0.5)
                                    Spacer()
                                }
                            }
                        }
                   }
                    .padding(.horizontal)
                    .padding(.bottom, 80)
                }
                
                VStack {
                    Spacer()
                   
                    NavigationLink(destination: WorkoutCameraView()) {
                        Text("Mulai")
                            .foregroundStyle(Color.custWhite)
                            .frame(maxWidth: .infinity, maxHeight: 40)
                            .background(Color.custOrange)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding()
                    }
                }
            }
            .foregroundColor(Color.custBlack)
            .navigationTitle(selectedWorkout)
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    GuidanceView()
}
