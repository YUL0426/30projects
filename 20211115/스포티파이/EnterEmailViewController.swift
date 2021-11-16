//
//  EnterEmailViewController.swift
//  spotifyLoginSampleApp
//
//  Created by YUL on 2021/11/15.
//

import UIKit

class EnterEmailViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var ErrorMessageLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //nextButton설정
        nextButton.layer.cornerRadius = 30
        //처음들어섰을때는 비활성화
        nextButton.isEnabled = false
        //입력받은 이메일,패스워드 파이어베이스 전달하기 위한 델리게이트 설정
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        //커서 바로 놓기
        emailTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //navigation bar 보이기
        navigationController?.navigationBar.isHidden = false
}
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
    }
}

extension EnterEmailViewController: UITextFieldDelegate {
    //비밀번호 입력이 끝났을 때 return 버튼을 누르면 키보드가 내려가도록
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true) //우리가 가지고 있는 뷰가 끝나면
        return false
    }
    //다음 버튼 활성화를 위한 델리게이팅
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == "" //비어있으면 엠티
        let isPasswordEmpty = passwordTextField.text == ""
        nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty //둘다 비어있지 않다면
    }
    
}
