//
//  LoginFormController.swift
//  Client VK
//
//  Created by Василий Петухов on 26.04.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import UIKit

class LoginFormController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
            // Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeybard))
            // Присваиваем его UIScrollVIew
        scrollViewLogin?.addGestureRecognizer(hideKeyboardGesture)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    // MARK: - Outlets
    @IBOutlet weak var scrollViewLogin: UIScrollView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Functions
    @objc func keyboardShow (notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let keyboardSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        self.scrollViewLogin?.contentInset = contentInset
        scrollViewLogin?.scrollIndicatorInsets = contentInset
    }
    
    @objc func keyboardHide (notification: Notification) {
        let contentInset = UIEdgeInsets.zero
        scrollViewLogin?.contentInset = contentInset
    }
    
    @objc func hideKeybard(){
        self.scrollViewLogin.endEditing(true)
    }
    
    
    // MARK: - Actions
    @IBAction func loginPushButton(_ sender: Any) {

        if loginTextField.text == "admin" && passwordTextField.text == "123456" {
            print("Успешная авторизация")
        } else {
            print("Логин или пароль указаны неверно!")
        }
    }
    
    
}
