//
//  DonePage.swift
//  MC3-FitMotion
//
//  Created by Citta Catherine Gozali on 18/07/24.
//

import SwiftUI

struct ExerciseDoneView: View {
    @Binding var totalset: Int//Ngambil total set & rep untuk dash
    @Binding var totalrep: Int
    
    var body: some View {
        ZStack {
            Color("Cream").edgesIgnoringSafeArea(.all) //background
            VStack{
                Image("youveDone")
                    .resizable()
                    .scaledToFill()
                    .frame(width:350,height:100)
                
                ZStack{
                    //Code circle
                    Circle()
                        .strokeBorder(Color("Orange"),style: StrokeStyle(lineWidth: 10, lineCap: .round, dash: dashSet))
                        .frame(width: 250, height: 250)
                        .padding()
                    Circle()
                        .strokeBorder(Color("Tosca"),style: StrokeStyle(lineWidth: 10, lineCap: .round,  dash: dashRep))
                        .frame(width: 300, height: 300)
                        .padding()
                    HStack{
                        VStack{
                            Text("Rep")
                                .foregroundColor(Color("CustGray"))
                                .font(.system(size: 16))
                                .fontWeight(.light)
                            Text("\(totalrep)")
                                .foregroundColor(Color("Tosca"))
                                .font(.system(size: 64))
                                .fontWeight(.bold)
                        }.frame(maxWidth:.infinity)
                            .padding(.leading,5)
                        Circle()
                            .frame(width: 5, height: 5)
                            .foregroundColor(Color("CustGray"))
                        VStack{
                            Text("Set")
                                .foregroundColor(Color("CustGray"))
                                .font(.system(size: 16))
                                .fontWeight(.light)
                            Text("\(totalset)")
                                .foregroundColor(Color("Orange"))
                                .font(.system(size: 64))
                                .fontWeight(.bold)
                        }.frame(maxWidth:.infinity)
                            .padding(.leading,5)
                    }.frame(width:200)
                }//End of lingkaran di tengah
                
                Text("Terus semangat! Konsisten berlatih untuk mendapatkan hasil maksimal.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("CustGray"))
                    .font(.system(size: 14))
                    .frame(width:350)
                Spacer().frame(height:100)
                Button(action: {
                    //Back to beginning
                }) {
            RoundedRectangle(cornerRadius: 20)
                        .fill(Color("Tosca"))
                        .overlay(Text("Selesai").foregroundColor(.white))
                        .frame(width:120,height:40)
                }
            }
            
        }
        .ignoresSafeArea()
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        
    }
    
    private var dashSet: [CGFloat] {
        let circumference = CGFloat.pi * 200
        let gapLength: CGFloat = 25//masih salah nanti harus diperbaiki
        let dashLength = (circumference - (CGFloat(totalset)+1) * gapLength) / CGFloat(totalset) // Dash length to fit the circumference
        return Array(repeating: [dashLength,gapLength], count: totalset).flatMap {$0}
    }
    private var dashRep: [CGFloat] {
        let circumference = CGFloat.pi * 300
        let gapLength: CGFloat = 25//masih salah nanti harus diperbaiki
        let dashLength = (circumference - (CGFloat(totalrep)+1) * gapLength) / CGFloat(totalrep)  // Dash length to fit the circumference
        return Array(repeating: [dashLength,gapLength], count: totalrep).flatMap {$0}
    }
}

#Preview {
    ExerciseDoneView(totalset: .constant(3), totalrep: .constant(12))
}

