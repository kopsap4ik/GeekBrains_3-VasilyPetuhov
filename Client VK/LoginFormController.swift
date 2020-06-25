//
//  LoginFormController.swift
//  Client VK
//
//  Created by Василий Петухов on 26.04.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import UIKit

class LoginFormController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // клик по любому месту scrollView для скрытия клавиатуры - Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // Присваиваем его UIScrollVIew
        scrollViewLogin?.addGestureRecognizer(hideKeyboardGesture)
        
        // * делегаты для переноса фокуса на следующее поле ввода
        self.loginTextField.delegate = self
        self.passwordTextField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // отписываемся от уведомлений в конце
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    // MARK: - Outlets
    @IBOutlet weak var scrollViewLogin: UIScrollView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Functions
    // Когда клавиатура появляется
    @objc func keyboardWillShow (notification: Notification) {
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let keyboardSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        scrollViewLogin?.contentInset = contentInset
        scrollViewLogin?.scrollIndicatorInsets = contentInset
    }
    
    //Убираем отступ, когда клавиатура исчезает
    @objc func keyboardWasHide (notification: Notification) {
        let contentInset = UIEdgeInsets.zero
        scrollViewLogin?.contentInset = contentInset
    }
    
    // клик по любому месту scrollView для скрытия клавиатуры
    @objc func hideKeyboard(){
        scrollViewLogin.endEditing(true)
    }
    
    // * переход на следующий TextField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            loginPushButton(self)
        }
        return true
    }
    
    
    // MARK: - Actions
    
    @IBAction func loginPushButton(_ sender: Any) {
// авторизация
        guard loginTextField.text == "admin" && passwordTextField.text == "123456" else {
            // Создаем контроллер для ошибки
            let alert = UIAlertController(title: "Ошибка", message: "Неверный логин или пароль!", preferredStyle: .alert)
            // Создаем и добавляем кнопку для UIAlertController
            let action = UIAlertAction(title: "Повторить", style: .cancel, handler: nil)
            alert.addAction(action)
            // Показываем UIAlertController
            present(alert, animated: true, completion: nil)
            return
        }
        performSegue(withIdentifier: "login", sender: nil)
    }
    

    
    // Для перехода на экран логина (exit например). Нужно добавить сегу от некой кнопки на exit в шапке нужного controllera
    @IBAction func segueToLoginController​(segue:UIStoryboardSegue) {
        // проверка и действия
    }
    
}
