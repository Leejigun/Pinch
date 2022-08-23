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
    @State private var isDrawerOpen: Bool = false
    
    private func resetImageState() {
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
                            resetImageState()
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
                                    resetImageState()
                                }
                            }
                    ) //: drag gesture
                    .animation(.linear(duration: 1), value: imageOffset)
                // MARK: - Magnification Gesture
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                if imageScale >= 1 && imageScale <= 5 {
                                    imageScale = value
                                } else if imageScale > 5 {
                                    imageScale = 5
                                }
                            }
                            .onEnded { _ in
                                if imageScale > 5 {
                                    imageScale = 5
                                } else if imageScale < 1 {
                                    resetImageState()
                                }
                            }
                    )
                
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
            // MARK: - Control
            .overlay(
                Group {
                    HStack {
                        // Scale down
                        Button {
                            if imageScale > 1 {
                                imageScale -= 1
                            }
                            
                            if imageScale <= 1 {
                                resetImageState()
                            }
                        } label: {
                            ControlImageView(icon: "minus.magnifyingglass")
                        }
                        
                        // Reset
                        Button {
                            resetImageState()
                        } label: {
                            ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        
                        
                        // Scale up
                        Button {
                            if imageScale < 5 {
                                imageScale += 1
                            }
                            
                            if imageScale > 5 {
                                imageScale = 5
                            }
                        } label: {
                            ControlImageView(icon: "plus.magnifyingglass")
                        }
                    }
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimation ? 1 : 0)
                }
                    .padding(.bottom, 30)
                , alignment: .bottom
            )
            // MARK: - Drawer
            .overlay(
                HStack {
                    // Header
                    Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .padding(8)
                        .foregroundStyle(.secondary)
                        .onTapGesture(perform: {
                            isDrawerOpen.toggle()
                        })
                    
                    // Thumbnails
                    Spacer()
                }
                    .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimation ? 1 : 0)
                    .frame(width: 260)
                    .padding(.top, UIScreen.main.bounds.height / 12)
                    .offset(x: isDrawerOpen ? 20 : 215)
                    .animation(.spring(), value: isDrawerOpen)
                , alignment: .topTrailing
            )
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

