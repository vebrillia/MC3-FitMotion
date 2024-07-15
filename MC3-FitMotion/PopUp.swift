//
//  PopUpGuide.swift
//  MC3-FitMotion
//
//  Created by Citta Catherine Gozali on 15/07/24.
//

import SwiftUI

struct PopUpGuide: ViewModifier {
    @Binding var isPresented: Bool
    
    @State private var offset: CGSize = .zero
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isPresented {
                VStack {
                    Spacer()
                    VStack {
                        TabView {
                            Text("Hello").tag(0)
                            Text("You").tag(1)
                        }
                    .tabViewStyle(PageTabViewStyle())
                    .frame(height: 200)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .offset(y: offset.height)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                offset = gesture.translation}
                            .onEnded { _ in
                                if offset.height > 100 {
                                    withAnimation {
                                        isPresented = false
                                        offset = .zero
                                    }
                                } else {
                                    withAnimation {
                                        offset = .zero
                                    }
                                }
                            }
                    )
                    .transition(.move(edge: .bottom))
                    .animation(.spring())
                }
                    Spacer().frame(height: 100)
                    
                }
            }
        }
    }
}

extension View {
        func swipableAlert(isPresented: Binding<Bool>) -> some View {self.modifier(PopUpGuide(isPresented: isPresented))
        }
    }


