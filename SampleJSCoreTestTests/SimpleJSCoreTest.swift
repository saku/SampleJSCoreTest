//
//  SimpleJSCoreTest.swift
//  SampleJSCoreTest
//
//  Created by SakuraiYoichiro on 2016/11/13.
//  Copyright © 2016年 Yoichiro Sakurai. All rights reserved.
//

import XCTest
import JavaScriptCore
@testable import SampleJSCoreTest

class SimpleJSCoreTest: XCTestCase {
    let context = JSContext()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSimpleValue() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        context.evaluateScript("var source = '3';")
        let value = context.evaluateScript("source;").toInt32()
        assert(value == 3, "check var value.")
    }

    func testSimpleFunction() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        context.evaluateScript("function testFunc(variable) { var num = Number(variable); return num + 1; }")
        let value = context.evaluateScript("testFunc(5);").toInt32()
        
        assert(value == 6, "check function value.")
    }
}
