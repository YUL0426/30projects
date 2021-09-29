//
//  Roundbutton.swift
//  calculator
//
//  Created by YUL on 2021/09/29.
//

import UIKit

@IBDesignable
class Roundbutton: UIButton {
    @IBInspectable var isRound: Bool = false {
        didSet {
            if isRound {
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
    }
}
