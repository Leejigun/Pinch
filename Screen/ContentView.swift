//
//  ContentView.swift
//  Pinch
//
//  Created by bimo.ez on 2022/08/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isAnimation: Bool = false
    @State private var imageScale: CGFloat = 1.0
    @State private var imageOffset: CGSize = .zero
    
    private func restImageState() {
        imageScale = 1
        imageOffset = .zero
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                
                // MARK: - Page Image
                Image("thumb-magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimation ? 1 : 0)
                    .animation(.linear(duration: 1), value: isAnimation)
                    .offset(imageOffset)
                    .scaleEffect(imageScale)
                // MARK: - Double Tap Gesture
                    .onTapGesture(count: 2) {
                        if imageScale == 1.0 {
                            imageScale = 5.0
                        } else {
                            restImageState()
                        }
                    } //: double tap gesture
                    .animation(.spring(), value: imageScale)
                // MARK: - Drag Gesture
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                imageOffset = gesture.translation
                            }
                            .onEnded { _ in
                                if imageScale <= 1 {
                                    restImageState()
                                }
                            }
                    ) //: drag gesture
                    .animation(.linear(duration: 1), value: imageOffset)
                
            } //: ZStack
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                isAnimation = true
            })
            // MARK: - Info Panel
            .overlay(
                InfoPanelView(scale: imageScale, offset: imageOffset)
                    .padding(.horizontal)
                    .padding(.top, 30)
                , alignment: .top)
        } //: NavigationView
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
    }
}

