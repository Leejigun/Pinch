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
    
    var body: some View {
        NavigationView {
            ZStack {
                // MARK: - Page Image
                Image("thumb-magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimation ? 1 : 0)
                    .scaleEffect(imageScale)
                    .onTapGesture(count: 2) {
                        if imageScale == 1.0 {
                            withAnimation(.spring()) {
                                imageScale = 5.0
                            }
                        } else {
                            withAnimation(.spring()) {
                                imageScale = 1.0
                            }
                        }
                    }
                    .animation(.linear(duration: 1), value: isAnimation)
            } //: ZStack
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                isAnimation = true
            })
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

