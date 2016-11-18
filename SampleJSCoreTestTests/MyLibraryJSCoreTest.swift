//
//  MyLibraryJSCoreTest.swift
//  SampleJSCoreTest
//
//  Created by SakuraiYoichiro on 2016/11/13.
//  Copyright © 2016年 Yoichiro Sakurai. All rights reserved.
//

import XCTest
import JavaScriptCore
@testable import SampleJSCoreTest

class MyLibraryJSCoreTest: XCTestCase {
    let context = JSContext()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        if let path = NSBundle.mainBundle().pathForResource("handlebars-v4.0.5", ofType: "js", inDirectory: "www/js") {
            let script = try! String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            context.evaluateScript(script)
        }
        if let path = NSBundle.mainBundle().pathForResource("handlebars-helper", ofType: "js", inDirectory: "www/js") {
            let script = try! String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            context.evaluateScript(script)
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExistLibraryTest() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let script = "var source = '{{#if value}}foo{{else}}bar{{/if}}';"
        var params, value : String

        params = "var params = { value : true };"
        context.evaluateScript(script)
        context.evaluateScript(params)
        context.evaluateScript("var template = Handlebars.compile(source);")
        value = context.evaluateScript("template(params);").toString()
        XCTAssert(value == "foo", "check library value.")

        params = "var params = { value : false };"
        context.evaluateScript(params)
        context.evaluateScript("template = Handlebars.compile(source);")
        value = context.evaluateScript("template(params);").toString()
        XCTAssert(value == "bar", "check 3rd library value.")
    }

    func testMyLibraryTest() {
        // Int
        _coreMyLibraryTest("3", condition: "<", right: "4", expect: true)
        _coreMyLibraryTest("3", condition: ">", right: "4", expect: false)
        _coreMyLibraryTest("3", condition: "!=", right: "4", expect: true)

        // float
        _coreMyLibraryTest("3.5", condition: "<", right: "3.501", expect: true)
        _coreMyLibraryTest("3.5", condition: "<=", right: "3.50", expect: true)

        // String
        _coreMyLibraryTest("'sample'", condition: "==", right: "'sample'", expect: true)
        _coreMyLibraryTest("'example'", condition: "!=", right: "'sample'", expect: true)
    }
    
    func _coreMyLibraryTest(left : String, condition: String, right: String, expect:Bool) {
        let script = "var source = '{{#ifCond left \"\(condition)\" right}}foo{{else}}bar{{/ifCond}}';"
        var params, value : String
        
        params = "var params = { left : \(left), right : \(right) };"
        context.evaluateScript(script)
        context.evaluateScript(params)
        context.evaluateScript("var template = Handlebars.compile(source);")
        value = context.evaluateScript("template(params);").toString()
        XCTAssert((value == "foo") == expect, "check my library value.")
    }
}
