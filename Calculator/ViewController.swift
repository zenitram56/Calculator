//
//  ViewController.swift
//  Calculator
//
//  Created by Brandon Martinez on 9/15/16.
//  Copyright © 2016 Brandon Martinez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var history: UILabel!
    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTypingANumber: Bool = false
    var dotCheck: Bool = false
   
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber{
            if (digit == "."){
                if !display.text!.containsString("."){
                    display.text = display.text! + digit
                    history.text = history.text! + digit
                }
                
                
            }else{
                display.text = display.text! + digit
                history.text = history.text! + digit

            }
         
        }else{
            dotCheck = false;
            display.text = digit
            history.text = history.text! + digit
            userIsInTheMiddleOfTypingANumber = true
        }
        
    }


    var operandStack: Array<Double> = Array<Double>()
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        history.text = history.text! + " "
        operandStack.append(displayValue)
        
        
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
            enter()
        }
        switch operation{
        case "✕":
            history.text = history.text! + " ✕ "
            performOperation { $0 * $1 }
        case "÷":
            history.text = history.text! + " ÷ "
            performOperation { $1 / $0 }
        case "＋":
            history.text = history.text! + "＋ "
            performOperation { $0 + $1 }
        case "−":
            history.text = history.text! + " − "
            performOperation { $1 - $0 }
        case "√":
            history.text = history.text! + " √ "
            performOperationSingle { sqrt($0)}
        case "C":
            operandStack.removeAll()
            display.text = "0"
            history.text = ""
        case "SIN":
            history.text = history.text! + " SIN "
            performOperationSingle { sin($0) }
        case "COS":
            history.text = history.text! + " COS "
            performOperationSingle { cos($0) }
        case "∏":
            displayValue = M_PI
            history.text = history.text! + " ∏ "
            enter()
        
        default: break
        }
    }
    func performOperation(operation: (Double, Double) -> Double){
        if operandStack.count >= 2{
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    func performOperationSingle(operation: Double -> Double){
        if operandStack.count >= 1{
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
   
    var displayValue: Double{
        get{
           return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            history.text =  history.text! + "= \(newValue) "
            userIsInTheMiddleOfTypingANumber = false
        }
    }

}


