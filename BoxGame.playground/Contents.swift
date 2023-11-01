
/*
 1) тип комната (ширина, высота)
 тип персонаж (х, у)
 функция печатает комнату и персонажа в ней (границы + персонаж + ящик)
 
 2) добавить персонажу метод идти (енум <- -> вверх вниз)
 3) персонаж не может выйти за пределы комнаты
 
 4) тип ящик (координаты) не может покидать комнату
 персонаж мог двигать ящик
 
 5) цель куда дотащить ящик
 */

enum Direction {
    case Left
    case Right
    case Up
    case Down
}

struct Point {
    var x = 0
    var y = 0
}

struct Game {
    var room: Room
    var player: Man
    var box: Box
    let finish: FinishPoint
    
    var gameEnded = false
    
    func render() {
        print()
        for i in 0..<room.height {
            for j in 0..<room.width {
                switch (j, i) {
                case (player.position.x, player.position.y):
                    print("\u{1F483}", terminator: "")
                case (box.position.x, box.position.y):
                    print("\u{1F4e6}", terminator: "")
                case (finish.position.x, finish.position.y):
                    print("\u{1f573}", terminator: "")
                default:
                    print("\u{2b1c}", terminator: "")
                }
            }
            print("\t")
        }
    }
    
    mutating func handleMove(direction: Direction) {
        let newPlayerPosition = calcPosition(point: player.position, direction: direction)
        
        if isPositionOutOfBounds(point: newPlayerPosition) {
            return
        }
        
        if newPlayerPosition.x == box.position.x && newPlayerPosition.y == box.position.y {
            let newBoxPosition = calcPosition(point: box.position, direction: direction)
            if isPositionOutOfBounds(point: newBoxPosition) {
                return
            } else {
                box.position = newBoxPosition
            }
        }
        
        player.position = newPlayerPosition
        render()
        
        checkGameEnded()
    }
    
    mutating func checkGameEnded() {
        if box.position.x == finish.position.x && box.position.y == finish.position.y && !gameEnded {
            gameEnded = true
            print(" You won!")
        }
    }
    
    func calcPosition(point: Point, direction: Direction) -> Point {
        var newPoint = point
        switch direction {
        case .Left:
            newPoint.x -= 1
        case .Right:
            newPoint.x += 1
        case .Up:
            newPoint.y -= 1
        case .Down:
            newPoint.y += 1
        }
        
        return newPoint
    }
    
    func isPositionOutOfBounds(point p: Point) -> Bool {
        if p.x < 0 || p.x > room.width - 1 || p.y < 0 || p.y > room.height - 1 {
            return true
        }
        
        return false
    }
}


struct Room {
    static let MaxDimension = 6
    let width: Int
    let height: Int
    
    init(width: Int, height: Int) {
        self.width = min(width, Room.MaxDimension)
        self.height = min(height, Room.MaxDimension)
    }
}

struct Man {
    var position = Point()
}

struct Box {
    var position: Point
}

struct FinishPoint {
    let position: Point
}

var man = Man(position: Point())
var box = Box(position: Point(x: 1, y: 1))
var room = Room(width: 4, height: 5)
let finish = FinishPoint(position: Point(x: 3, y: 4))

var game = Game(room: room, player: man, box: box, finish: finish)
game.render()

game.handleMove(direction: .Right)
game.handleMove(direction: .Down)
game.handleMove(direction: .Down)
game.handleMove(direction: .Down)
game.handleMove(direction: .Left)
game.handleMove(direction: .Down)
game.handleMove(direction: .Right)
game.handleMove(direction: .Right)
game.handleMove(direction: .Up)

