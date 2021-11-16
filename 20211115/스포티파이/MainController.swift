오늘은 스포티파이 앱을 통해 로그인하는 방법을 배울 것이다.

//
//  MainViewController.swift
//  spotifyLoginSampleApp
//
//  Created by YUL on 2021/11/15.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    override func viewDidLoad() {
        //POP 제스쳐 방지
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    //main에선 보여주지 않을 것
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
