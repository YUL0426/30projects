//
//  ViewController.swift
//  calculator
//
//  Created by YUL on 2021/09/29.
//

import UIKit

enum Operation {
    case Add
    case Subtract
    case Divide
    case Multiply
    case unknown
}

class ViewController: UIViewController {
    @IBOutlet weak var numberOutputLabel: UILabel!
    
    var displayNumber = " "
    var firstOperand = " "
    var secondOperand = " "
    var result = " "
    var currentOperation: Operation = .unknown
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapNumberButton(_ sender: UIButton) {
        guard let numberValue = sender.title(for: .normal) else { return }
        if self.displayNumber.count < 9 {
            self.displayNumber += numberValue
            self.numberOutputLabel.text = self.displayNumber
        }
    }
    
    @IBAction func tapClearButton(_ sender: UIButton) {
    }
    
    @IBAction func tapDotButton(_ sender: UIButton) {
    }
    @IBAction func tapDivideButton(_ sender: UIButton) {
    }
    @IBAction func tapMultiplyButton(_ sender: UIButton) {
    }
    @IBAction func tapSubtractButton(_ sender: UIButton) {
    }
    @IBAction func tapAddButton(_ sender: UIButton) {
    }
    
    @IBAction func tapEqualButton(_ sender: UIButton) {
    }
}

