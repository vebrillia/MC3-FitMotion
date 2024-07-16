//
//  OverlaySetRepCounter.swift
//  MC3-FitMotion
//
//  Created by Citta Catherine Gozali on 16/07/24.
//

import SwiftUI


struct OverlaySetRepCounter: ViewModifier {
    @Binding var isPresented: Bool
    @State var buttonAvail: Bool = false
    
    @State private var offset: CGFloat = 0
    @State var selection: Int = 0
    
    
    
    func body(content: Content) -> some View {
        ZStack{
            content
        }
    }
}
