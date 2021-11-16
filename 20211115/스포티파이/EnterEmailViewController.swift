//
//  EnterEmailViewController.swift
//  spotifyLoginSampleApp
//
//  Created by YUL on 2021/11/15.
//

import UIKit
import FirebaseAuth

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
        //Firebase 이메일/비밀번호 인증
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        //신규 사용자 생성
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                let code  = (error as NSError).code
                switch code {
                case 17007: //이미 가입한 계정일 때
                    //로그인하기
                    self.loginUser(withEmail: email, password: password)
                default:
                    self.ErrorMessageLabel.text = error.localizedDescription
                }
            } else {
            self.showMainViewController() // 로그인이 제대로 됐을 시
        }
    }
}
    //코드 정상 실행 시 MVC 실행
    private func showMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.show(mainViewController, sender: nil)
    }
    
    private func loginUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            guard let self = self else { return }
            
            if let error = error {
                self.ErrorMessageLabel.text = error.localizedDescription
            } else {
                self.showMainViewController()
            }
            
        }
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
