//
//  Day1_2024.swift
//  AdventOfCode
//
//  Created by Niccolò Fontana on 07/12/24.
//

enum Day1_2024 {
    static let sampleInput = """
3   4
4   3
2   5
1   3
3   9
3   3
"""
    static func runPartOne() -> Int {
        var l1: [Int] = []
        var l2: [Int] = []
        let idsPairs = Utils.readInputFile(day: 1, year: 2024).components(separatedBy: .newlines)
        l1.reserveCapacity(idsPairs.count)
        l2.reserveCapacity(idsPairs.count)
        
        for pair in idsPairs {
            guard !pair.isEmpty else { continue }
            
            let ids = pair.split(separator: Character(" "))
            guard ids.count == 2,
                  let id1 = Int(ids[0]),
                  let id2 = Int(ids[1])
            else {
                fatalError("List corrupted")
            }
            l1.append(id1)
            l2.append(id2)
        }
        
        l1.sort()
        l2.sort()
        
        return zip(l1, l2).reduce(into: 0, { partialResult, ids in
            let (id1, id2) = ids
            partialResult += abs(id1 - id2)
        })
    }
    
    static func runPartTwo() -> Int {
        // Occurrences of the given ID in the second list
        var occurences: [Int: Int] = [:]
        // IDs that appear in the first list
        var l1: [Int] = []
        
        for row in Utils.readInputFile(day: 1, year: 2024).components(separatedBy: .newlines) {
            guard !row.isEmpty else { continue }
            let ids = row.split(separator: Character(" "))
            guard ids.count == 2,
                  let id1 = Int(ids[0]),
                  let id2 = Int(ids[1]) else {
                fatalError("List corrupted")
            }
            
            if let n = occurences[id2] {
                occurences[id2] = n + 1
            } else {
                occurences[id2] = 1
            }
            
            l1.append(id1)
        }
        
        return l1.reduce(into: 0) { partialResult, id in
            if let n = occurences[id] {
                partialResult += id * n
            }
        }
    }
}
