//
//  MainViewController.swift
//  spotifyLoginSampleApp
//
//  Created by YUL on 2021/11/15.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    override func viewDidLoad() {
        //POP 제스쳐 방지
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    //main에선 보여주지 않을 것
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        let email = Auth.auth().currentUser?.email ?? "고객"
        
        welcomeLabel.text = """
        환영합니다.
        \(email)님
        """
        
    }
    
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("ERROR: singout \(signOutError.localizedDescription)")
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
}
