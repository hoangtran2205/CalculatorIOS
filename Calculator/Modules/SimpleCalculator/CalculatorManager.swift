//
//  CalculatorManager.swift
//  Calculator
//
//  Created by tmhoang1904 on 6/18/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

enum Operator {
    case addition
    case subtraction
    case multiplication
    case division
}

protocol Calculator {
    var printer: CalculatorPrinter { get set }

    /**
    Calculate 2 numbers with given operator
    - Parameter firstNumber: The first number to calculate
    - Parameter secondNumber: The second number to calculate
    - Parameter _operator: Operator should perform with these two numbers
     - Returns: The result of calculation. Nil when has invalid operator like number / 0
    */
    func calculate(firstNumber: Decimal, secondNumber: Decimal, _operator: Operator) -> Decimal?
}

class SimpleCalculatorManager: Calculator {
    private var _printer: CalculatorPrinter

    var printer: CalculatorPrinter {
        get { return self._printer }
        set { self._printer = newValue }
    }

    required init(printer: CalculatorPrinter) {
        self._printer = printer
    }

    
    func calculate(firstNumber: Decimal, secondNumber: Decimal, _operator: Operator) -> Decimal? {
        switch _operator {
        case .addition:
            return firstNumber + secondNumber
        case .subtraction:
            return firstNumber - secondNumber
        case .multiplication:
            return firstNumber * secondNumber
        case .division:
            return secondNumber != 0 ? firstNumber / secondNumber : nil
        }
    }


}
