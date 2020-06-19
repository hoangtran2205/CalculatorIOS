//
//  ViewController.swift
//  Calculator
//
//  Created by tmhoang1904 on 6/18/20.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import PKHUD

class SimpleCalculatorController: UIViewController {

    @IBOutlet weak var lblResult: UILabel!

    @IBOutlet weak var btnAC: UIButton!
    @IBOutlet weak var btnDivision: UIButton!
    @IBOutlet weak var btnMultiplication: UIButton!
    @IBOutlet weak var btnSubtraction: UIButton!
    @IBOutlet weak var btnAddition: UIButton!
    @IBOutlet weak var btnEqual: UIButton!

    @IBOutlet weak var btnNumber0: UIButton!
    @IBOutlet weak var btnNumber1: UIButton!
    @IBOutlet weak var btnNumber2: UIButton!
    @IBOutlet weak var btnNumber3: UIButton!
    @IBOutlet weak var btnNumber4: UIButton!
    @IBOutlet weak var btnNumber5: UIButton!
    @IBOutlet weak var btnNumber6: UIButton!
    @IBOutlet weak var btnNumber7: UIButton!
    @IBOutlet weak var btnNumber8: UIButton!
    @IBOutlet weak var btnNumber9: UIButton!
    @IBOutlet weak var btnDot: UIButton!

    let disposedBag = DisposeBag()

    //Store all number buttons, using tag as number value, so easier to control and less code
    var numberButtons: [UIButton]!

    var selectedOperator: Operator?
    var firstNumber: Decimal?
    var secondNumber: Decimal?
    var hasOperator: Bool = false
    var isInNewRound = true //If operators chaining will continue as new number

    let result: BehaviorRelay<String> = BehaviorRelay(value: "0")

    var calculatorManager: Calculator!

    override func viewDidLoad() {
        super.viewDidLoad()

        calculatorManager = SimpleCalculatorManager(printer: SimpleCalculatorPrinter())

        // Do any additional setup after loading the view.
        setupViews()
        setupObservables()
    }


    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension SimpleCalculatorController {
    func setupViews() {
        numberButtons = [btnNumber0, btnNumber1, btnNumber2, btnNumber3, btnNumber4, btnNumber5, btnNumber6, btnNumber7, btnNumber8, btnNumber9]

        //Add tap gesture to label for copying
        lblResult.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer()
        lblResult.addGestureRecognizer(tapGesture)
        tapGesture.rx.event.bind(onNext: { _ in
            UIPasteboard.general.string = self.lblResult.text
            HUD.flash(.label("Copied"), delay: 0.5)
        }).disposed(by: disposedBag)

        //Bind result to label
        result.bind(to: lblResult.rx.text).disposed(by: disposedBag)
    }

    func setupObservables() {
        //Setup number buttons
        numberButtons.forEach { button in
            button.rx.tap.bind {
                self.handleNumberPress(num: button.tag)
            }.disposed(by: disposedBag)
        }

        //Setup clear button
        btnAC.rx.tap.bind {
            self.resetCalculator()
        }.disposed(by: disposedBag)

        //Setup dot button
        btnDot.rx.tap.bind {
            self.handleDotPress()
        }.disposed(by: disposedBag)

        //Setup Operator buttons
        btnAddition.rx.tap.bind {
            self.handleOperatorPress(.addition)
        }.disposed(by: disposedBag)

        btnSubtraction.rx.tap.bind {
            self.handleOperatorPress(.subtraction)
        }.disposed(by: disposedBag)

        btnMultiplication.rx.tap.bind {
            self.handleOperatorPress(.multiplication)
        }.disposed(by: disposedBag)

        btnDivision.rx.tap.bind {
            self.handleOperatorPress(.division)
        }.disposed(by: disposedBag)

        //Setup equal button
        btnEqual.rx.tap.bind {
            self.handleEqualPress()
        }.disposed(by: disposedBag)
    }

    func resetCalculator() {
        self.result.accept("0")
        self.firstNumber = nil
        self.secondNumber = nil
        self.hasOperator = false
        self.selectedOperator = nil
    }

    func handleDotPress() {
        var newText = self.result.value
        if isInNewRound {
            newText = "0."
        }

        let hasDot = newText.contains(".")
        if !hasDot {
            newText += "."
        }

        if self.hasOperator {
            self.secondNumber = Decimal(string: newText)
        } else {
            self.firstNumber = Decimal(string: newText)
        }
        self.result.accept(newText)
        self.isInNewRound = false
    }

    func handleNumberPress(num: Int) {
        var isAppend = true
        var newText = ""

        if self.isInNewRound {
            isAppend = false
        }

        if isAppend {
            newText = self.result.value + String(num)
        } else {
            newText = String(num)
        }


        if self.hasOperator {
            self.secondNumber = Decimal(string: newText)
        } else {
            self.firstNumber = Decimal(string: newText)
        }

        self.result.accept(newText)
        self.isInNewRound = false
    }

    func handleOperatorPress(_ _operator: Operator) {
        if self.hasOperator {
            self.calculate()
            self.secondNumber = nil
        }
        //Only accept new operator when have at least one number has input
        if self.firstNumber != nil || self.secondNumber != nil {
            self.selectedOperator = _operator
            self.hasOperator = true
            self.isInNewRound = true
        }
    }

    func handleEqualPress() {
        self.calculate()
        self.hasOperator = false
        self.selectedOperator = nil
        self.secondNumber = nil
        self.isInNewRound = true
    }

    func calculate() {
        if let firstNumber = self.firstNumber,
            let secondNumber = self.secondNumber,
            let selectedOperator = self.selectedOperator {
            let result = self.calculatorManager.calculate(firstNumber: firstNumber, secondNumber: secondNumber, _operator: selectedOperator)            

            self.result.accept(self.calculatorManager.printer.getDisplayResult(result: result))

            self.firstNumber = result
        }
    }
}
