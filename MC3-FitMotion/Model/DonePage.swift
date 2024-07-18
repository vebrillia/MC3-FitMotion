//
//  DonePage.swift
//  MC3-FitMotion
//
//  Created by Citta Catherine Gozali on 18/07/24.
//

import SwiftUI

struct DonePage: View {
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
                            Text("Repetisi")
                                .foregroundColor(Color("CustGray"))
                                .font(.system(size: 16))
                                .fontWeight(.light)
                            Text("\(totalrep)")
                                .foregroundColor(Color("Tosca"))
                                .font(.system(size: 64))
                                .fontWeight(.bold)
                        }
                    }
                    Text("\(totalrep)")
                    Text("\(totalset)")
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
    DonePage(totalset: .constant(3), totalrep: .constant(12))
}

