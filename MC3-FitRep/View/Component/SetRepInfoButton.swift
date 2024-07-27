//
//  RepInfoButton.swift
//  MC3-FitRep
//
//  Created by Christian on 24/07/24.
//

import SwiftUI

struct SetRepInfoButton: View {
    @State private var isShowingPopover = false
    
    var body: some View {
        Button(action: {
            self.isShowingPopover.toggle()
        }) {
            Image(systemName: "info.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 12, height: 12)
                .foregroundStyle(Color.custTosca)
                .padding(.top, 1)
        }
        .popover(isPresented: $isShowingPopover, arrowEdge: .trailing, content: {
            ScrollView {
                Text("Rekomendasi jumlah repetisi tergantung pada target yang ingin dicapai sebagai berikut :\n\nStrength : <5 Rep\nMuscle Growth : 5-15 Rep\nMuscle Tone : >15 Rep")
                    .font(.caption)
                    .padding(.horizontal)
                    .frame(width: 180, height: 140)
                    .presentationCompactAdaptation(.popover)
                    .presentationBackgroundInteraction(.enabled)
            }
            
        })
        .padding(.trailing)
    }
}

#Preview {
    SetRepInfoButton()
}
