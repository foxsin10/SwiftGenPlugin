import XCTest
@testable import PluginTest

final class PluginTestTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(PluginTest().text, "Hello, World!")

        XCTAssert(!Asset.tint.name.isEmpty)
    }
}
