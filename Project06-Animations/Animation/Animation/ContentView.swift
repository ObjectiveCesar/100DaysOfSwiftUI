//
//  ContentView.swift
//  Animation
//
//  Created by Lippmann, Erik on 15.07.22.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView: View {
    @State private var bindingAnimationAmount = 1.0
    @State private var impliciteAnimationAmount = 1.0
    @State private var expliciteAnimationAmount = 0.0
    @State private var enabled = false

    @State private var dragAmount = CGSize.zero

    let letters = Array("Hello, SwiftUI")

    @State private var isShowingRed = false

    var body: some View {
        NavigationView {
            Form {
                Section("Transition Modifier") {
                    ZStack {
                        Rectangle()
                            .fill(.blue)
                            .frame(width: 200, height: 200)

                        if isShowingRed {
                            Rectangle()
                                .fill(.red)
                                .frame(width: 200, height: 200)
                                .transition(.pivot)
                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            isShowingRed.toggle()
                        }
                    }
                }

                Section("Showing and hiding views") {
                    VStack {
                        Button("Tap Me") {
                            withAnimation {
                                isShowingRed.toggle()
                            }
                        }

                        if isShowingRed {
                            Rectangle()
                                .fill(Color.red)
                                .frame(width: 200, height: 200)
                                .transition(.asymmetric(insertion: .opacity, removal: .scale))
                        }
                    }
                }

                Section("Dragging with Offset") {
                    HStack(spacing: 0) {
                        ForEach(0..<letters.count) { num in
                            Text(String(letters[num]))
                                .padding(5)
                                .font(.title)
                                .background(enabled ? .blue : .red)
                                .offset(dragAmount)
                                .animation(
                                    .default.delay(Double(num) / 20), value: dragAmount)
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { dragAmount = $0.translation }
                            .onEnded { _ in
                                dragAmount = .zero
                                enabled.toggle()
                            }
                    )
                }

                Section("Dragging") {
                    LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .frame(width: 300, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .offset(dragAmount)
                        .gesture(
                            DragGesture()
                                .onChanged { dragAmount = $0.translation }
                                .onEnded { _ in
                                    withAnimation {
                                        dragAmount = .zero
                                    }
                                }
                        )
                }
                Section("Multiple Animations") {
                    Button("Tap Me") {
                        enabled.toggle()
                    }
                    .frame(width: 200, height: 200)
                    .background(enabled ? .blue : .red)
                    .animation(nil, value: enabled)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
                    .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
                }

                Section("Explicit Animation") {
                    Button("Tap Me") {
                        withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                            expliciteAnimationAmount += 360
                        }
                    }
                    .padding(50)
                    .background(.red)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .rotation3DEffect(.degrees(expliciteAnimationAmount), axis: (x: 0, y: 1, z: 0))
                }

                // Binding Animation
                Section("Binding Animation") {
                    Stepper("Scale amount", value: $bindingAnimationAmount.animation(
                        .easeInOut(duration: 1)
                        .repeatCount(3, autoreverses: true)
                    ), in: 1...10)

                    Button("Tap Me") {
                        bindingAnimationAmount += 1
                    }
                    .padding(50)
                    .background(.red)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .scaleEffect(bindingAnimationAmount)
                }

                // Implicit animation
                Section("Implicit Animation") {
                    Button("Tap Me") {
                        // animationAmount += 1
                    }
                    .padding(50)
                    .background(.red)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(.red)
                            .scaleEffect(impliciteAnimationAmount)
                            .opacity(2 - impliciteAnimationAmount)
                            .animation(
                                .easeInOut(duration: 1)
                                .repeatForever(autoreverses: false),
                                value: impliciteAnimationAmount
                            )
                    }
                    .onAppear {
                        impliciteAnimationAmount = 2
                    }
                }

            }
            .navigationTitle("Animations")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
