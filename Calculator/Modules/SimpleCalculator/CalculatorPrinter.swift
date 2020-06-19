//
//  CalculatorPrinter.swift
//  Calculator
//
//  Created by tmhoang1904 on 6/18/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

protocol CalculatorPrinter {
    /**
       Get  presentable String
    - Parameter result: Result to display.
    */
    func getDisplayResult(result: Decimal?) -> String
    /**
           Print result to debug log
           - Parameter result: Result to display
    */
    func printResult(result: Decimal?) -> Void
}

class SimpleCalculatorPrinter: CalculatorPrinter {
    let numberFormatter = NumberFormatter()

    init() {
        numberFormatter.maximumFractionDigits = 8        
        numberFormatter.roundingMode = .halfUp
    }
    
    func getDisplayResult(result: Decimal?) -> String {
        if let result = result {
            let isInteger = floor(result.double) == result.double
            return isInteger ? String(result.int) : numberFormatter.string(for: result.double)!
        }

        return "Not a number"
    }

    
    func printResult(result: Decimal?) {
        print("Calculation result: \(self.getDisplayResult(result: result))")
    }

}
