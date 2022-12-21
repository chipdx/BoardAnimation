//
//  Board.swift
//  BoardAnimation
//
//  Created by Chip Dickinson on 12/20/22.
//

import Foundation

struct Board: Codable {
    let id: Int
    let description: String
    let action: BoardAction
    let x, y, offsetX, offsetY: Int

    enum CodingKeys: String, CodingKey {
        case id
        case description
        case action, x, y, offsetX, offsetY
    }

    static let loadBoard: [Board] = Bundle.main.decode(file: "Board.json")
    static let sampleBoard: Board = loadBoard[0]
}

enum BoardAction: String, Codable {
    case advanceToExit = "Advance to Exit"
    case empty = ""
    case finish = "Finish"
    case lose1Turn = "Lose 1 Turn"
    case mountSeir = "Mount Seir"
    case return3 = "Return 3"
    case return5 = "Return 5"
    case return6 = "Return 6"
    case specialCard = "Special Card"
}
