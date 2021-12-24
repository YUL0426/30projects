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
    var timer : DispatchSourceTimer?    //OPTIONAL이되도록 뒤에 물음표
    var currentSeconds = 0
    
    
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
    
    func startTimer() {
        if self.timer == nil {
            self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            self.timer?.schedule(deadline: .now(), repeating: 1) // "지금부터" "1초마다" 반복
            self.timer?.setEventHandler(handler: { [weak self] in
                
                
                if self.currentSeconds  <= 0 {
                    // 타이머종료
                    self.stopTimer()
                }
            })
            self.timer?.resume()
        }
    }
    
    func stopTimer() {
        if self.timerStatus == .pause {
            self.timer?.resume()
        }
        self.timerStatus = .end
        self.cancelButton.isEnabled = false
        self.setTimerInfoViewVisible(isHidden: true)    //time,프로그레스뷰가 표시되지 않도록
        self.datePicker.isHidden = false // datepicker가다시표시되도록
        self.toggleButton.isSelected = false // togglebutton 타이틀이 선택되도록
        self.timer?.cancel()
        self.timer = nil
    }
    
    @IBAction func tapCancelButton(_ sender: UIButton) {
        switch self.timerStatus {
        case .start, .pause:
            self.stopTimer()
            
        default:
            break
        }
    }
    
    @IBAction func tapTogglerButton(_ sender: UIButton) {
        self.duration = Int(self.datePicker.countDownDuration) //countdownduration = 시간이 몇초인지 알려줌
        switch self.timerStatus {
        case .end:
            self.currentSeconds = self.duration
            self.timerStatus = .start
            //timer라벨과 프로그레스뷰 포시되도록(start를 눌렀으니까)
            self.setTimerInfoViewVisible(isHidden: false)
            self.datePicker.isHidden = true
            self.toggleButton.isSelected = true
            self.cancelButton.isEnabled = true // 취소버튼활성화되도록
            self.startTimer()
            
        case .start:
            self.timerStatus = .pause
            self.toggleButton.isSelected = false
            self.timer?.suspend()
            
        case .pause:
            self.timerStatus = .start
            self.toggleButton.isSelected = true
            self.timer?.resume()
        }
    }
    
}

# 타이머기능 구현(시분초 표시, 알람종료시 알람음 설정)
//
//  ViewController.swift
//  pomodoro
//
//  Created by YUL on 2021/12/24.
//

import UIKit
import AudioToolbox             //알람을 설정을 위한 import

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
    var timer : DispatchSourceTimer?    //OPTIONAL이되도록 뒤에 물음표
    var currentSeconds = 0
    
    
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
    
    func startTimer() {
        if self.timer == nil {
            self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            self.timer?.schedule(deadline: .now(), repeating: 1) // "지금부터" "1초마다" 반복
            self.timer?.setEventHandler(handler: { [weak self] in
                guard let self = self else { return }
                self.currentSeconds -= 1 //1초에한번씩 호출하며 감소시킨다
                let hour = self.currentSeconds / 3600   // 시각 구하기
                let minute = (self.currentSeconds % 3600) / 60
                let seconds = (self.currentSeconds % 3600) % 60
                self.timerLabel.text = String(format: "%02d:%02d:%02d", hour, minute, seconds) //timelabel 표시
                
                self.progressView.progress = Float(self.currentSeconds) / Float(self.duration) //왜냐하면 progressview는 float타입으로 대입하여야함
                
                if self.currentSeconds  <= 0 {
                    // 타이머종료
                    self.stopTimer()
                    // 종료되었을 시 아이폰 기본사운드 울릴 수 있도록
                    AudioServicesPlaySystemSound(1005)
                }
            })
            self.timer?.resume()
        }
    }
    
    func stopTimer() {
        if self.timerStatus == .pause {
            self.timer?.resume()
        }
        self.timerStatus = .end
        self.cancelButton.isEnabled = false
        self.setTimerInfoViewVisible(isHidden: true)    //time,프로그레스뷰가 표시되지 않도록
        self.datePicker.isHidden = false // datepicker가다시표시되도록
        self.toggleButton.isSelected = false // togglebutton 타이틀이 선택되도록
        self.timer?.cancel()
        self.timer = nil
    }
    
    @IBAction func tapCancelButton(_ sender: UIButton) {
        switch self.timerStatus {
        case .start, .pause:
            self.stopTimer()
            
        default:
            break
        }
    }
    
    @IBAction func tapTogglerButton(_ sender: UIButton) {
        self.duration = Int(self.datePicker.countDownDuration) //countdownduration = 시간이 몇초인지 알려줌
        switch self.timerStatus {
        case .end:
            self.currentSeconds = self.duration
            self.timerStatus = .start
            //timer라벨과 프로그레스뷰 포시되도록(start를 눌렀으니까)
            self.setTimerInfoViewVisible(isHidden: false)
            self.datePicker.isHidden = true
            self.toggleButton.isSelected = true
            self.cancelButton.isEnabled = true // 취소버튼활성화되도록
            self.startTimer()
            
        case .start:
            self.timerStatus = .pause
            self.toggleButton.isSelected = false
            self.timer?.suspend()
            
        case .pause:
            self.timerStatus = .start
            self.toggleButton.isSelected = true
            self.timer?.resume()
        }
    }
    
}

#6 uiview animation을 이용해 역동적인 효과 주기
//
//  ViewController.swift
//  pomodoro
//
//  Created by YUL on 2021/12/24.
//

import UIKit
import AudioToolbox

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
    
    @IBOutlet weak var imageView: UIImageView!
    //타이머에 설정된 시간을 초로 저장하는 프로퍼티
    var duration = 60
    var timerStatus: TimerStatus = .end        //초기값end로 설정
    var timer : DispatchSourceTimer?    //OPTIONAL이되도록 뒤에 물음표
    var currentSeconds = 0
    
    
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
    
    func startTimer() {
        if self.timer == nil {
            self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            self.timer?.schedule(deadline: .now(), repeating: 1) // "지금부터" "1초마다" 반복
            self.timer?.setEventHandler(handler: { [weak self] in
                guard let self = self else { return }
                self.currentSeconds -= 1 //1초에한번씩 호출하며 감소시킨다
                let hour = self.currentSeconds / 3600   // 시각 구하기
                let minute = (self.currentSeconds % 3600) / 60
                let seconds = (self.currentSeconds % 3600) % 60
                self.timerLabel.text = String(format: "%02d:%02d:%02d", hour, minute, seconds) //timelabel 표시
                
                self.progressView.progress = Float(self.currentSeconds) / Float(self.duration) //왜냐하면 progressview는 float타입으로 대입하여야함
                
                // 토마토 빙글빙글
                UIView.animate(withDuration: 0.5, delay: 0, animations: {
                    self.imageView.transform = CGAffineTransform(rotationAngle: .pi)
                    // CGAFFINETRANSFORM : 구조체, 뷰의프레임을 계산하지 않고 사용하여 2d 그래픽 그리기 가능 / 뷰 이동 회전 스케일 작업 가능
                })
                UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
                    self.imageView.transform = CGAffineTransform(rotationAngle: .pi * 2)
                })
                
                
                if self.currentSeconds  <= 0 {
                    // 타이머종료
                    self.stopTimer()
                    // 종료되었을 시 아이폰 기본사운드 울릴 수 있도록
                    AudioServicesPlaySystemSound(1005)
                }
            })
            self.timer?.resume()
        }
    }
    
    func stopTimer() {
        if self.timerStatus == .pause {
            self.timer?.resume()
        }
        self.timerStatus = .end
        self.cancelButton.isEnabled = false
        UIView.animate(withDuration: 0.5, animations: {
            self.timerLabel.alpha = 0
            self.progressView.alpha = 0
            self.datePicker.alpha = 1
            self.imageView.transform = .identity
        })
        self.toggleButton.isSelected = false // togglebutton 타이틀이 선택되도록
        self.timer?.cancel()
        self.timer = nil
    }
    
    @IBAction func tapCancelButton(_ sender: UIButton) {
        switch self.timerStatus {
        case .start, .pause:
            self.stopTimer()
            
        default:
            break
        }
    }
    
    @IBAction func tapTogglerButton(_ sender: UIButton) {
        self.duration = Int(self.datePicker.countDownDuration) //countdownduration = 시간이 몇초인지 알려줌
        switch self.timerStatus {
        case .end:
            self.currentSeconds = self.duration
            self.timerStatus = .start
            UIView.animate(withDuration: 0.5, animations: {
                self.timerLabel.alpha = 1
                self.progressView.alpha = 1
                self.datePicker.alpha = 0
            })
            self.toggleButton.isSelected = true
            self.cancelButton.isEnabled = true // 취소버튼활성화되도록
            self.startTimer()
            
        case .start:
            self.timerStatus = .pause
            self.toggleButton.isSelected = false
            self.timer?.suspend()
            
        case .pause:
            self.timerStatus = .start
            self.toggleButton.isSelected = true
            self.timer?.resume()
        }
    }
    
}


