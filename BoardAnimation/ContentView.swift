//
//  ContentView.swift
//  BoardAnimation
//
//  Created by Chip Dickinson on 12/20/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var game = Game()
    
    @State var numToMove: Int = 5
    @State var movingToken: Bool = false
    
    let playerWidth = CGFloat(60)
    let color = Color.red
    
    let tokenWidth: CGFloat = 50
    let tokenHeight: CGFloat = 50
    
    let moveAnimationSpeed: Double = 0.5
    
    let timer = Timer.publish(every: 0.8, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            HStack {
                VStack(spacing: 2) {
                    Rectangle()
                        .fill(.yellow)
                        .frame(width: playerWidth, height: 5)
                    
                    ZStack {
                        Rectangle()
                            .fill(color)
                            .frame(width: playerWidth, height: 25)
                        
                        Text("Player 1")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
                    
                    Text("\(game.boardPosition)")
                        .font(.footnote)
                        .foregroundColor(color)
                }
                
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
                HStack {
                    Button {
                        game.move = numToMove
                        game.moveToken()
                    } label: {
                        Text("Move")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Stepper(value: $numToMove, in: -20...20) {
                        Text("#: \(numToMove)")
                            .frame(width: 50)
                    }
                }
            }
            .padding()
            .frame(height: 50)
            
            ScrollView(.horizontal, showsIndicators: true) {
                ZStack {
                    Image("Board")
                        .zIndex(0)
                    
                    Image("Token")
                        .antialiased(true)
                        .resizable()
                        .frame(width: tokenWidth, height: tokenHeight)
                        .position(game.boardPoint)
                        .offset(y: movingToken ? -10 : 0)
                        .animation(.linear(duration: 0.5 / moveAnimationSpeed), value: game.boardPosition)
//                        .animation(.easeOut(duration: 0.5 / moveAnimationSpeed), value: game.boardPosition)
//                        .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5), value: game.boardPosition)
                    //                        .animation(Animation.interpolatingSpring(stiffness: 170,
                    //                                                                 damping: 5), value: game.boardPosition)
                        .foregroundColor(color)
                        .zIndex(1)
                }
                .onReceive(timer) { _ in
                    withAnimation {
                        if game.boardPosition < game.endPosition {
                            movingToken = true
                            
                            let delay = Int(moveAnimationSpeed * 1000)
                            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delay) ) {
                                game.boardPosition += 1
                                movingToken = false
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
