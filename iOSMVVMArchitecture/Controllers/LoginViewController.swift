//
//  LoginViewController.swift
//  iOSMVVMArchitecture
//
//  Created by Amit Shukla on 04/03/20.
//  Copyright © 2020 Amit Shukla. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var emailTxtF: CustomTextField!
    @IBOutlet weak var passwordTxtF: CustomTextField!
    
    lazy var viewModel: UserViewModel = {
       
        let obj = UserViewModel(with: UserService())
        
        obj.onLoginSuccess = { [weak self] () in
            DispatchQueue.main.async {
                // Do your stuff here
            }
        }
        self.baseViewModel = obj
        
        return obj
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
    }

    @IBAction func onLoginClicked(_ sender: Any) {
        //self.viewModel.login(with: self.emailTxtF.text, password: self.passwordTxtF.text)
        guard let image = UIImage(named: "userimage") else { return }
        let service = UserService()
        service.uploadFile(image) { (message) in
            
        }
    }
    @IBAction func onRememberClicked(_ sender: UIButton) {
       sender.isSelected = !sender.isSelected
    }
    
}

