//
//  DocumentTests.swift
//  CodeCombat
//
//  Created by Michael Schmatz on 8/27/14.
//  Copyright (c) 2014 CodeCombat. All rights reserved.
//

import Foundation
import XCTest

class DocumentHighlighterTests: XCTestCase {
  
  let provider = LanguageProvider()
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testSimpleExampleParsing() {
    let parser = LanguageParser(scope: "example", data: "char const* str = \"Hello world\\n\"", provider: provider)
    let parseRootNode = parser.parse()
    //write more tests here for example
    XCTAssertTrue(parseRootNode != nil, "The parse root node shouldn't be nil")
  }
  
  func testSimpleJavascriptParsing() {
    let parser = LanguageParser(scope: "javascript", data: "var blah = 5; var test = function() { console.log(\"Hello World\");};", provider: provider)
    let parseRootNode = parser.parse()
    print(parseRootNode.description())
    XCTAssertTrue(parseRootNode != nil, "The parse root node shouldn't be nil.")
  }
  
  func testSimpleJavascriptParsing1() {
    let documentString = "var blah = 5;" as NSString
    let parser = LanguageParser(scope: "javascript", data: documentString, provider: provider)
    let rootNode = parser.parse()
    XCTAssertEqual(rootNode.name, "source.js")
    XCTAssertEqual(rootNode.range.location, 0)
    XCTAssertEqual(rootNode.range.length, documentString.length)
    XCTAssertEqual(rootNode.children.count, 5)
    let childZero = rootNode.children[0]
    XCTAssertEqual(childZero.name, "storage.type.js")
    XCTAssertEqual(childZero.data, "var")
    XCTAssertEqual(childZero.range.location, 0)
    XCTAssertEqual(childZero.range.length, 3)
    XCTAssertEqual(childZero.children.count, 0)
    let childOne = rootNode.children[1]
    XCTAssertEqual(childOne.name,"variable.other.readwrite.js")
    XCTAssertEqual(childOne.data, "blah")
    XCTAssertEqual(childOne.range.location, 4)
    XCTAssertEqual(childOne.range.length, 4)
    let childTwo = rootNode.children[2]
    XCTAssertEqual(childTwo.name, "keyword.operator.js")
    XCTAssertEqual(childTwo.data, "=")
    XCTAssertEqual(childTwo.range.location, 9)
    XCTAssertEqual(childTwo.range.length, 1)
    let childThree = rootNode.children[3]
    XCTAssertEqual(childThree.name, "constant.numeric.js")
    XCTAssertEqual(childThree.data, "5")
    XCTAssertEqual(childThree.range.location, 11)
    XCTAssertEqual(childThree.range.length, 1)
    let childFour = rootNode.children[4]
    XCTAssertEqual(childFour.name, "punctuation.terminator.statement.js")
    XCTAssertEqual(childFour.data, ";")
    XCTAssertEqual(childFour.range.location, 12)
    XCTAssertEqual(childFour.range.length, 1)
  }
  
  func testSimpleJavascriptParsing2() {
    let documentString = "function blah(parameterOne, parameterTwo) {\n return 5; };\n"
    let parser = LanguageParser(scope: "javascript", data: documentString, provider: provider)
    let rootNode = parser.parse()
    print(rootNode.description())
  }
  
  func testJavascriptStringParsing() {
    let documentString = "var blah = \"Hello World\";"
    let parser = LanguageParser(scope: "javascript", data: documentString, provider: provider)
    let rootNode = parser.parse()
    print(rootNode.description())
  }
  
  func testNodeHighlighter() {
    let documentString = "var blah = \"Hello World\";"
    let parser = LanguageParser(scope: "javascript", data: documentString, provider: self.provider)
    let highlighter = NodeHighlighter(parser: parser)
    print(highlighter.scopeName(1))
    print(highlighter.scopeExtent(1))
  }
  
  func testPythonParsing1() {
    let documentString = "friends = ['john', 'pat', 'gary', 'michael']\nfor i, name in enumerate(friends):\n\tprint \"iteration {iteration} is {name}\".format(iteration=i, name=name)\n"
    let parser = LanguageParser(scope: "python", data: documentString, provider: provider)
    let rootNode = parser.parse()
    print(rootNode.description())
  }
  
  func testPythonParsingComments() {
    let documentString = "self.attack(hello,goodbye)"
    let parser = LanguageParser(scope: "python", data: documentString, provider: provider)
    let rootNode = parser.parse()
    print(rootNode.description())
  }
  func testPerformanceExample() {
    // This is an example of a performance test case.
    let documentString = "var blah = 5;" as NSString
    let parser = LanguageParser(scope: "javascript", data: documentString, provider: provider)
    self.measureBlock() {
      // Put the code you want to measure the time of here.
      let rootNode = parser.parse()
    }
  }
  
}
