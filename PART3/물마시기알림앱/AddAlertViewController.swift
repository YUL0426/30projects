//
//  AddAlertViewController.swift
//  DrinkAlarm
//
//  Created by YUL on 2021/12/24.
//

import UIKit

class AddAlertViewController: UIViewController {
    // 확인버튼 누를시 부모뷰에 전달될수로있도록, 클로져
    // date값을 받고, void를반환하는 클로져(있을지/없을지)
    var pickedDate: ((_ date: Date) -> Void)?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBAction func dismissButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtontapped(_ sender: UIBarButtonItem) {
        pickedDate?(datePicker.date)
        self.dismiss(animated: true, completion: nil)
    }
}
