//
//  CalculatorPrinter.swift
//  Calculator
//
//  Created by tmhoang1904 on 6/18/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

protocol CalculatorPrinter {
    func getDisplayResult(result: Decimal?) -> String
    func printResult(result: Decimal?) -> Void
}

class SimpleCalculatorPrinter: CalculatorPrinter {
    func getDisplayResult(result: Decimal?) -> String {
        if let result = result {
            let isInteger = result.exponent == 0
            return isInteger ? String(result.int) : result.string
        }

        return "Not a number"
    }

    func printResult(result: Decimal?) {
        print("Calculation result: \(self.getDisplayResult(result: result))")
    }

}
