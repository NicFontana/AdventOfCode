import Testing
@testable import AdventOfCode

@Suite("2024 Tests") struct Tests_2024 {
  @Test func test_Day1() {
      #expect(Day1_2024.runPartOne() == 3574690)
      #expect(Day1_2024.runPartTwo() == 22565391)
  }
}
