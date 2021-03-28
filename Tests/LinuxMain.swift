import XCTest

import lz77Tests

var tests = [XCTestCaseEntry]()
tests += lz77Tests.allTests()
XCTMain(tests)
