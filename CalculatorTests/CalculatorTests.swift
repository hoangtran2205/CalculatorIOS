//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by tmhoang1904 on 6/18/20.
//  Copyright © 2020 Home. All rights reserved.
//

import XCTest
@testable import Calculator

class CalculatorTests: XCTestCase {

    static let MAX_CALCULATIONS = 10000

    var firstNumbers: [Decimal] = []
    var secondNumbers: [Decimal] = []

    var calculatorManager: Calculator!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        calculatorManager = SimpleCalculatorManager(printer: SimpleCalculatorPrinter())

        for _ in 0..<CalculatorTests.MAX_CALCULATIONS - 3 {
            firstNumbers.append(Decimal(Double.random(in: -100000000...100000000)))
            secondNumbers.append(Decimal(Double.random(in: -100000000...100000000)))
        }

        //Append 0 element for testing division operator
        firstNumbers.append(Decimal(Double.random(in: -100000000...100000000)))
        secondNumbers.append(0)

        //Append some special cases
        firstNumbers.append(0)
        secondNumbers.append(Decimal(Double.random(in: -100000000...100000000)))

        firstNumbers.append(0)
        secondNumbers.append(0)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddition() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        for index in 0..<firstNumbers.count {
            let firstNumber = firstNumbers[index]
            let secondNumber = secondNumbers[index]

            let actualResult = calculatorManager.calculate(firstNumber: firstNumber, secondNumber: secondNumber, _operator: .addition)
            let expectedResult = firstNumber + secondNumber

            XCTAssertEqual(actualResult!, expectedResult)
        }
    }

    func testSubtraction() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        for index in 0..<firstNumbers.count {
            let firstNumber = firstNumbers[index]
            let secondNumber = secondNumbers[index]

            let actualResult = calculatorManager.calculate(firstNumber: firstNumber, secondNumber: secondNumber, _operator: .subtraction)
            let expectedResult = firstNumber - secondNumber

            XCTAssertEqual(actualResult!, expectedResult)
        }
    }

    func testMultiplication() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        for index in 0..<firstNumbers.count {
            let firstNumber = firstNumbers[index]
            let secondNumber = secondNumbers[index]

            let actualResult = calculatorManager.calculate(firstNumber: firstNumber, secondNumber: secondNumber, _operator: .multiplication)
            let expectedResult = firstNumber * secondNumber

            XCTAssertEqual(actualResult!, expectedResult)
        }
    }

    func testDivision() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        for index in 0..<firstNumbers.count {
            let firstNumber = firstNumbers[index]
            let secondNumber = secondNumbers[index]

            let actualResult = calculatorManager.calculate(firstNumber: firstNumber, secondNumber: secondNumber, _operator: .division)
            let expectedResult = secondNumber != 0 ? firstNumber / secondNumber : nil


            if actualResult == nil {
                XCTAssertNil(expectedResult)
            } else {
                XCTAssertEqual(actualResult!, expectedResult)
            }
        }
    }

}
