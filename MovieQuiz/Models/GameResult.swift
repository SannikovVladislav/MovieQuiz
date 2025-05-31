import Foundation

struct GameResult {
    let correct: Int
    let total: Int
    let date: Date
    func compare (result: GameResult) -> Bool {
        correct > result.correct
    }
}
