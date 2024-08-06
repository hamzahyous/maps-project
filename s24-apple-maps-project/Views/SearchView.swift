//
//  SearchView.swift
//  s24-apple-maps-project
//
//  Created by Hamzah Yousuf on 4/17/24.
//

import SwiftUI


struct SearchView: View {
    
    @ObservedObject var mapAPI: MapAPI
    @ObservedObject var searchHistory: SearchHistory
    
    @Binding var isShowing: Bool
    @State private var text = ""
    @State private var isDragging = false
    
    @State private var currentHeight: CGFloat = 400
    let minHeight: CGFloat = 400
    let maxHeight: CGFloat = 600
    
    let startOpacity: Double = 0.4
    let endOpacity: Double = 0.8
    
    var dragPercentage: Double {
        let res = Double((currentHeight - minHeight) / (maxHeight - minHeight))
        return max(0, min(1, res))
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                Color.black
                    .opacity(startOpacity + (endOpacity - startOpacity) * dragPercentage)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing = false
                    }
                
                mainView
                .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
    
    var mainView: some View {
        VStack {
            
            ZStack {
                Capsule()
                    .frame(width: 40, height: 6)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.00001))
            .gesture(dragGesture)
            ZStack {
                VStack {
                    TextField("Enter an address", text: $text)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                    Button("Find Address") {
                        mapAPI.getLocation(address: text, delta: 0.5) {
                            // Done so the task can complete before the sheet dismisses.
                            DispatchQueue.main.async {
                                searchHistory.searches.append(text)
                                isShowing = false
                            }
                        }
                    }
                }
                .padding(.horizontal, 30)
            }
            .frame(maxHeight: .infinity)
            .padding(.bottom, 35)
        }
        .frame(height: currentHeight)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                Rectangle()
                    .frame(height: currentHeight / 2)
            }
                .foregroundStyle(.white)
        )
        .animation(isDragging ? nil: .easeInOut(duration: 0.45))
    }
    
    @State private var prevDragTranslation = CGSize.zero
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { val in
                if !isDragging {
                    isDragging = true
                }
                let dragAmount = val.translation.height - prevDragTranslation.height
                if currentHeight > maxHeight || currentHeight < minHeight {
                    currentHeight -= dragAmount / 6
                } else {
                    currentHeight -= dragAmount
                }
                
                prevDragTranslation = val.translation
            }
            .onEnded { val in
                prevDragTranslation = .zero
                isDragging = false
                if currentHeight < minHeight {
                    currentHeight = minHeight
                }
            }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
