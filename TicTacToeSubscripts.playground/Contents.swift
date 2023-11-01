// Task1: Chess Desk

//enum CellColor: String {
//    case White
//    case Black
//}
//
//struct Desk {
//    static let rows = [1, 2, 3, 4, 5, 6, 7, 8]
//    static let columns: [Character] = ["a", "b", "c", "d", "e", "f", "g", "h"]
//
//    static func positionIsValid(column: Character, row: Int) -> Bool {
//        return columns.contains(Character(String(column).lowercased())) && rows.contains(row)
//    }
//
//    subscript(column: Character, row: Int) -> CellColor? {
//        get {
//            assert(Desk.positionIsValid(column: column, row: row), "Invalid position on the desk")
//            return (Desk.columns.firstIndex(of: column)! + 1) % 2 == row % 2 ? .Black : .White
//        }
//    }
//}
//
//let myDesk = Desk()
//myDesk["b", 8]


// Task2: tic-tac-toe

enum Cell: String {
    case Empty = "\u{2b1c}"
    case Cross = "\u{274c}"
    case Circle = "\u{1f7e1}"
    
    mutating func swap() {
        self = self == .Cross ? .Circle : .Cross
    }
}

struct Field {
    let size: Int
    var cells: [Cell]
    
    func cellIsValid(row: Int, col: Int) -> Bool {
        return row > 0 && row <= size && col > 0 && col <= size
    }
    
    init(size: Int) {
        self.size = size
        self.cells = Array.init(repeating: .Empty, count: size*size)
    }
    
    func render() {
        for (idx, cell) in cells.enumerated() {
            print(cell.rawValue, terminator: "")
            if idx != 0 && (idx + 1) % 3 == 0 {
                print("\t")
            }
        }
        print("\t")
    }
}

struct Game {
    private var field = Field(size: 3)
    private var turn = Cell.Cross
    private var gameEnded = false
    
    init() {
        print("\(turn.rawValue) is starting")
        field.render()
    }
    
    func checkWin() -> Bool {
        let winCriteria = {$0 == turn}
        
        var diagR = [Cell]()
        var diagL = [Cell]()
        for i in 0..<field.size {
            var column = [Cell]()
            var row = [Cell]()
            for j in 0..<field.size {
                if i == j {
                    diagR.append(field.cells[i * field.size + j])
                }
                
                if j == field.size - i - 1 {
                    diagL.append(field.cells[i * field.size + j])
                }
                
                column.append(field.cells[i * field.size + j])
                row.append(field.cells[j * field.size + i])
            }
            
            if column.allSatisfy(winCriteria) || row.allSatisfy(winCriteria) {
                return true
            }
        }
        
        if diagR.allSatisfy(winCriteria) || diagL.allSatisfy(winCriteria) {
            return true
        }

        return false
    }
    
    func checkGameEnded() -> Bool {
        return field.cells.allSatisfy { $0 != .Empty }
    }
    
    subscript(row: Int, col: Int) -> Void {
        mutating get {
            if gameEnded {
                return
            }
            assert(field.cellIsValid(row: row, col: col), "Cell is out of field")
            let cellIdx = (row - 1) * 3 + (col - 1)
            
            assert(field.cells[cellIdx] == .Empty, "Cell is not empty")
            field.cells[cellIdx] = turn
            
            field.render()
            
            if checkWin() {
                gameEnded = true
                print("Congratulations! \(turn.rawValue) won")
            } else if checkGameEnded() {
                gameEnded = true
                print("Game ended")
            } else {
                turn.swap()
            }
        }
    }
}

var game = Game()
game[1, 1]
game[2, 2]
game[1, 2]
game[1, 3]
game[2, 3]
game[2, 1]
// uncomment to win
//game[3, 2]
//game[3, 1]
// uncomment to end game
game[3, 2]
game[3, 3]
game[3, 1]


// X wons game:
//game[2, 2]
//game[1, 2]
//game[2, 3]
//game[2, 1]
//game[1, 3]
//game[3, 3]
//game[3, 1]
