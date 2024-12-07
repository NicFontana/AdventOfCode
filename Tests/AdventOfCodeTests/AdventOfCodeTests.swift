import Testing
@testable import AdventOfCode

@Suite("2024 Tests") struct Tests_2024 {
    @Test func test_Day1() {
        #expect(Day1_2024.solvePartOne() == 3574690)
        #expect(Day1_2024.solvePartTwo() == 22565391)
    }
    
    @Test func test_Day4() {
        #expect(Day4_2024.solvePartOne() == 2468)
        #expect(Day4_2024.solvePartOneRecursively() == 2468)
        #expect(Day4_2024.solvePartTwo() == 1864)
    }
}
