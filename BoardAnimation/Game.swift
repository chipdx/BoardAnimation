//
//  Game.swift
//  BoardAnimation
//
//  Created by Chip Dickinson on 12/20/22.
//

import SwiftUI

class Game: ObservableObject {
    @Published var boardPosition: Int = 0 {
        didSet {
            setPoint()
        }
    }
    
    @Published var boardPoint: CGPoint = CGPoint(x: 145, y: 170)
    
    var endPosition: Int = 0
    
    var board: [Board] = Board.loadBoard
    
    var action = "forward"
    var move = 0
    
    var moveAnimation = true
    
    func setPoint() {
        if boardPosition < 0 {
            boardPosition = 0
        }
        
        let board = board[boardPosition]
        
        let x = CGFloat(board.x)
        let y = CGFloat(board.y)
        
        boardPoint = CGPoint(x: x, y: y)
        
        if endPosition > 0 && endPosition == boardPosition {
            endPosition = 0
            boardAction()
        }
    }
    
    func moveToken() {
        var pos = boardPosition
        
        if action == "return" {
            pos -= move
        } else {
            pos += move
        }
        
        if pos < 0 {
            pos = 0
            
        } else if pos > 99 {
            pos = 99
        }
        
        endPosition = 0
        
        if moveAnimation {
            endPosition = pos
        } else {
            boardPosition = pos
            boardAction()
        }
        
    }
    
    func boardAction() {
        let boardAction = board[boardPosition].action
        var pos = boardPosition
        
        switch boardAction {
        case .advanceToExit: boardPosition = 99
        case .finish: boardPosition = 48
        case .return3: pos = -3
        case .return5: pos = -5
        case .return6: pos = -6
        default: pos = 0            // Do nothing
        }
        
        if pos < 0 {
            pos = boardPosition + pos
            
            if pos < 1 {
                pos = 0
            }
            
            boardPosition = pos
        }
    }
}
