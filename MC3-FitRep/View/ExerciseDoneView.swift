//
//  DonePage.swift
//  MC3-FitMotion
//
//  Created by Citta Catherine Gozali on 18/07/24.
//

import SwiftUI

struct ExerciseDoneView: View {
    @Binding var totalSet: Int//Ngambil total set & rep untuk dash
    @Binding var totalRep: Int
    
    var body: some View {
        ZStack {
            Color.custWhite.edgesIgnoringSafeArea(.all) //background
            VStack{
                Image("DoneExercise")
                    .resizable()
                    .scaledToFill()
                    .frame(width:350,height:100)
                
                ZStack{
                    //Code circle
                    Circle()
                        .strokeBorder(Color.custOrange,style: StrokeStyle(lineWidth: 10, lineCap: .round, dash: dashSet))
                        .frame(width: 250, height: 250)
                        .padding()
                    Circle()
                        .strokeBorder(Color.custTosca,style: StrokeStyle(lineWidth: 10, lineCap: .round,  dash: dashRep))
                        .frame(width: 300, height: 300)
                        .padding()
                    HStack{
                        VStack{
                            Text("Rep")
                                .foregroundColor(Color.custBlack)
                                .font(.system(size: 16))
                                .fontWeight(.light)
                            Text("\(totalRep)")
                                .foregroundColor(Color.custTosca)
                                .font(.system(size: 64))
                                .fontWeight(.bold)
                        }.frame(maxWidth:.infinity)
                            .padding(.leading,5)
                        Circle()
                            .frame(width: 5, height: 5)
                            .foregroundColor(Color.custBlack)
                        VStack{
                            Text("Set")
                                .foregroundColor(Color.custBlack)
                                .font(.system(size: 16))
                                .fontWeight(.light)
                            Text("\(totalSet)")
                                .foregroundColor(Color.custOrange)
                                .font(.system(size: 64))
                                .fontWeight(.bold)
                        }.frame(maxWidth:.infinity)
                            .padding(.leading,5)
                    }.frame(width:200)
                }//End of lingkaran di tengah
                
                Text("Terus semangat! Konsisten berlatih untuk mendapatkan hasil maksimal.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.custBlack)
                    .font(.system(size: 14))
                    .frame(width:350)
                Spacer().frame(height:100)
               
                NavigationLink(destination: GuidanceView()) {
                    Text("Selesai")
                        .foregroundStyle(Color.fontWhite)
                        .frame(width: 120, height: 40)
                        .background(Color.custTosca)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                }
                .background(Color.custWhite)
                
            }
            
        }
        .ignoresSafeArea()
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        
    }
    
    private var dashSet: [CGFloat] {
        let circumference = CGFloat.pi * 200
        let gapLength: CGFloat = 25//masih salah nanti harus diperbaiki
        let dashLength = (circumference - (CGFloat(totalSet)+1) * gapLength) / CGFloat(totalSet) // Dash length to fit the circumference
        return Array(repeating: [dashLength,gapLength], count: totalSet).flatMap {$0}
    }
    private var dashRep: [CGFloat] {
        let circumference = CGFloat.pi * 300
        let gapLength: CGFloat = 25//masih salah nanti harus diperbaiki
        let dashLength = (circumference - (CGFloat(totalRep)+1) * gapLength) / CGFloat(totalRep)  // Dash length to fit the circumference
        return Array(repeating: [dashLength,gapLength], count: totalRep).flatMap {$0}
    }
}

#Preview {
    ExerciseDoneView(totalSet: .constant(3), totalRep: .constant(12))
}

