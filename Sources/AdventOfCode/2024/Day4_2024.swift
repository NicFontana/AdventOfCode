//
//  Day4_2024.swift
//  AdventOfCode
//
//  Created by Niccolò Fontana on 07/12/24.
//

enum Day4_2024 {
    static let sampleInput = """
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
"""
    
    enum Direction: CaseIterable {
        case left, leftUp, up, rightUp, right, rightDown, down, leftDown
        
        var value: (x: Int, y: Int) {
            switch self {
            case .left: (-1, 0)
            case .leftUp: (-1, -1)
            case .up: (0, -1)
            case .rightUp: (1, -1)
            case .right: (1, 0)
            case .rightDown: (1, 1)
            case .down: (0, 1)
            case .leftDown: (-1, 1)
            }
        }
    }
    
    // MARK: - Part 1
    
    static func solvePartOne() -> Int {
        let matrix: [[Character]] = Utils.readInputFile(day: 4, year: 2024)
            .components(separatedBy: .newlines)
            .compactMap { $0.isEmpty ? nil : Array($0) }
        
        let xmasCount = search("XMAS", in: matrix)
        
        return xmasCount
    }
    
    private static func search(_ word: String, in matrix: [[Character]]) -> Int {
        var count = 0
        
        for y in 0..<matrix.count {
            for x in 0..<matrix[y].count {
                for direction in Direction.allCases {
                    
                    var found = true
                    var coordinates: [(y: Int, x: Int)] = []
                    
                    for i in 0..<word.count {
                        let nextY = y + direction.value.y * i
                        let nextX = x + direction.value.x * i
                        
                        if nextY < 0 || nextY > matrix.count - 1 || nextX < 0 || nextX > matrix[y].count - 1 {
                            found = false
                            break
                        }
                        
                        if matrix[nextY][nextX] != word[word.index(word.startIndex, offsetBy: i)] {
                            found = false
                            break
                        }
                        
                        coordinates.append((y: nextY, x: nextX))
                    }
                    
                    if found {
                        let word = coordinates.map { c in
                            matrix[c.y][c.x]
                        }
                        print("Found", coordinates, "=>", word)
                        count += 1
                    }
                }
            }
        }
        
        return count
    }
    
    // MARK: - Part 1 recursively
    
    static func solvePartOneRecursively() -> Int {
        let matrix: [[Character]] = Utils.readInputFile(day: 4, year: 2024)
            .components(separatedBy: .newlines)
            .compactMap { $0.isEmpty ? nil : Array($0) }
        
        let xmasCount = recursiveSearch("XMAS", in: matrix)
        
        return xmasCount
    }
    
    private static func recursiveSearch(_ word: String, in matrix: [[Character]]) -> Int {
        var count = 0
        for y in 0..<matrix.count {
            for x in 0..<matrix[y].count {
                for direction in Direction.allCases {
                    if recursiveSearch(word,
                                       in: matrix,
                                       startingAt: (y: y, x: x),
                                       along: direction,
                                       currentFinding: String(matrix[y][x])) {
                        count += 1
                    }
                }
            }
        }
        return count
    }
    
    private static func recursiveSearch(_ word: String, in matrix: [[Character]], startingAt position: (y: Int, x: Int), along direction: Direction, currentFinding: String) -> Bool {
        if matrix.isEmpty {
            return false
        }
        
        if !word.starts(with: currentFinding) {
            return false
        }
        
        if currentFinding == word {
            return true
        }
        
        if currentFinding.count == word.count {
            return false
        }
        
        let nextY = position.y + direction.value.y
        let nextX = position.x + direction.value.x
        if  nextY > matrix.count - 1 || nextY < 0 || nextX > matrix[0].count - 1 || nextX < 0 {
            return false
        }
        
        let nextFinding = "\(currentFinding)\(matrix[nextY][nextX])"
        
        return recursiveSearch(word, in: matrix, startingAt: (y: nextY, x: nextX), along: direction, currentFinding: nextFinding)
    }
    
    // MARK: - Part 2
    
    static func solvePartTwo() -> Int {
        let matrix: [[Character]] = Utils.readInputFile(day: 4, year: 2024)
            .components(separatedBy: .newlines)
            .compactMap { $0.isEmpty ? nil : Array($0) }
        
        return crossSearch("MAS", in: matrix)
    }
    
    private static func checkWord(_ word: String, in matrix: [[Character]], from startingPoint: (y: Int, x: Int), direction: Direction) -> Bool {
        for i in 0..<word.count {
            let nextY = startingPoint.y + direction.value.y * i
            let nextX = startingPoint.x + direction.value.x * i
            
            guard matrix[nextY][nextX] == word[word.index(word.startIndex, offsetBy: i)] else {
                return false
            }
        }
        return true
    }
    
    static func crossSearch(_ word: String, in matrix: [[Character]]) -> Int {
        var count = 0
        
        guard !word.count.isMultiple(of: 2) else {
            return count
        }
        
        let middleCharIndex = word.index(word.startIndex, offsetBy: word.count / 2)
        let middleChar = word[middleCharIndex]
        
        let reversedWord = String(word.reversed())
        
        for y in 0..<matrix.count {
            for x in 0..<matrix[y].count {
                guard matrix[y][x] == middleChar &&
                        y >= word.count / 2 && x >= word.count / 2 &&
                        y < matrix.count - (word.count / 2) && x < matrix[y].count - (word.count / 2)
                else { continue }
                
                let topLeftStartingPoint = (y: y - word.count / 2, x: x - word.count / 2)
                let topRightStartingPoint = (y: y - word.count / 2, x: x + word.count / 2)
                
                if (
                    checkWord(word, in: matrix, from: topLeftStartingPoint, direction: .rightDown) ||
                    checkWord(reversedWord, in: matrix, from: topLeftStartingPoint, direction: .rightDown))
                    &&
                    (checkWord(word, in: matrix, from: topRightStartingPoint, direction: .leftDown) ||
                     checkWord(reversedWord, in: matrix, from: topRightStartingPoint, direction: .leftDown)) {
                    count += 1
                }
            }
        }
        
        return count
    }
    
}
