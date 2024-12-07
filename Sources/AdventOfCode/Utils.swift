//
//  Utils.swift
//  AdventOfCode
//
//  Created by Niccolò Fontana on 07/12/24.
//

import Foundation

enum Utils {
    static func readInputFile(day: Int, year: Int) -> String {
        guard let resourceUrl = Bundle.module.url(forResource: "Inputs/day\(day)_\(year)", withExtension: "txt") else {
            fatalError("Cannot find input file")
        }
        
        do {
            let resourceData = try Data(contentsOf: resourceUrl)
            guard let string = String(data: resourceData, encoding: .utf8) else {
                fatalError("Cannot decode input file")
            }
            return string
        } catch {
            fatalError("Cannot read input file \(error)")
        }
    }
}
