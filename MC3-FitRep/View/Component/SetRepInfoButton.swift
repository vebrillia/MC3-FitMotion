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
                .frame(width: 20, height: 20)
                .foregroundStyle(Color.custTosca)
        }
        .popover(isPresented: $isShowingPopover, arrowEdge: .top, content: {
            Text("Jumlah set dalam workout berkisar antara 3-6 set\nRepetisi dalam workout tergantung dari target yang diinginkan dan berkaitan dengan kemampuan dalam mengangkat beban.\n\nStrength : <5 Rep\nMuscle Growth : 5-15 Rep\nMuscle Tone : >15 Rep\n\nContoh, jka ingin mengambil jumlah repetisi dibawah 5, maka carilah beban yang memang tidak bisa diangkat melebihi 5 repetisi. Begitu juga untuk jumlah repetisi lainnya. Jika beban yang diangkat lebih ringan dari kemampuan yang ada, tidak akan terjadi pertumbuhan pada otot.")
                .font(.caption)
                .padding(.horizontal)
                .frame(height: 260)
                .presentationCompactAdaptation(.popover)
                .presentationBackgroundInteraction(.enabled)
        })
        .padding(.trailing)
    }
}

#Preview {
    SetRepInfoButton()
}
