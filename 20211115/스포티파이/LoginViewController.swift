//
//  LoginViewController.swift
//  spotifyLoginSampleApp
//
//  Created by YUL on 2021/11/15.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //각 로그인 항목의 border 설정
        [emailLoginButton, googleLoginButton, appleLoginButton].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30 //모서리 둥근모양 처리
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Navigation Bar 숨기기
        navigationController?.navigationBar.isHidden = true
    }
    
    
    
    @IBAction func GoogleLoginButtonTapped(_ sender: UIButton) {
        //Firebase 인증 코드
    }
    
    @IBAction func appleLoginButtonTapped(_ sender: UIButton) {
    }
    
}
