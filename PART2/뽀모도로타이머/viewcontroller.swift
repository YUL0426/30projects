//
//  ViewController.swift
//  pomodoro
//
//  Created by YUL on 2021/12/24.
//

import UIKit

enum TimerStatus {
    case start
    case pause
    case end
}

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var toggleButton: UIButton!
    
    //타이머에 설정된 시간을 초로 저장하는 프로퍼티
    var duration = 60
    var timerStatus: TimerStatus = .end        //초기값end로 설정
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureToggleButton()
    }
    
    func setTimerInfoViewVisible(isHidden: Bool) {
        self.timerLabel.isHidden = isHidden
        self.progressView.isHidden = isHidden
    }
    
    func configureToggleButton() {
        self.toggleButton.setTitle("시작", for: .normal)
        self.toggleButton.setTitle("일시정지", for: .selected)
        //버튼의 상태에 따라 title변경
    }
    
    @IBAction func tapCancelButton(_ sender: UIButton) {
        switch self.timerStatus {
        case .start, .pause:
            self.timerStatus = .end
            self.cancelButton.isEnabled = false
            self.setTimerInfoViewVisible(isHidden: true)    //time,프로그레스뷰가 표시되지 않도록
            self.datePicker.isHidden = false // datepicker가다시표시되도록
            self.toggleButton.isSelected = false // togglebutton 타이틀이 시작이 되도록
        default:
            break
        }
    }
    
    @IBAction func tapTogglerButton(_ sender: UIButton) {
        self.duration = Int(self.datePicker.countDownDuration) //countdownduration = 시간이 몇초인지 알려줌
        switch self.timerStatus {
        case .end:
            self.timerStatus = .start
            //timer라벨과 프로그레스뷰 포시되도록(start를 눌렀으니까)
            self.setTimerInfoViewVisible(isHidden: false)
            self.datePicker.isHidden = true
            self.toggleButton.isSelected = true
            self.cancelButton.isEnabled = true // 취소버튼활성화되도록
            
            
        case .start:
            self.timerStatus = .pause
            self.toggleButton.isSelected = false
            
        case .pause:
            self.timerStatus = .start
            self.toggleButton.isSelected = true
        }
    }
    
}

