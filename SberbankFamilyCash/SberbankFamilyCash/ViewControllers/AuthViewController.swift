//
//  ViewController.swift
//  SberbankFamilyCash
//
//  Created by Николай Спиридонов on 16.11.2019.
//  Copyright © 2019 nnick. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    private var nameField: UITextField!
    private var logoView: UIImageView!
    private var passwordField: UITextField!
    private var authButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        setLogo()
        setNameField()
        setPasswordField()
        setAuthButton()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing(sender:))))
    }
    
    private func setLogo() {
        logoView = UIImageView()
        logoView.backgroundColor = .clear
        
        logoView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(logoView)
        
        logoView.image = #imageLiteral(resourceName: "sberLogo")
        
        logoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        logoView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        logoView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
        logoView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        logoView.contentMode = .scaleAspectFit
    }
    
    private func setNameField() {
        nameField = UITextField()
        nameField.backgroundColor = #colorLiteral(red: 0.9210130572, green: 0.9253756404, blue: 0.9426833987, alpha: 1)
        nameField.placeholder = " Имя"
        
        nameField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(nameField)
        
        
        nameField.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 30).isActive = true
        nameField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        nameField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nameField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        nameField.layer.cornerRadius = 10
        nameField.delegate = self
    }
    
    private func setPasswordField() {
        passwordField = UITextField()
        passwordField.backgroundColor = #colorLiteral(red: 0.9210130572, green: 0.9253756404, blue: 0.9426833987, alpha: 1)
        passwordField.placeholder = " Пароль"
        
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(passwordField)
        
        passwordField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 15).isActive = true
        passwordField.widthAnchor.constraint(equalTo: nameField.widthAnchor).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        passwordField.layer.cornerRadius = 10
        passwordField.delegate = self
    }
    
    private func setAuthButton() {
        authButton = UIButton(type: .system)
        authButton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        authButton.setTitle("Войти", for: .normal)
        authButton.setTitleColor(.white, for: .normal)
        authButton.addTarget(self, action: #selector(showMainScreen), for: .touchUpInside)

        authButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(authButton)
        
        authButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 15).isActive = true
        authButton.widthAnchor.constraint(equalTo: passwordField.widthAnchor).isActive = true
        authButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        authButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        authButton.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    @objc private func endEditing(sender: UITapGestureRecognizer) {
        guard let _ = view.hitTest(sender.location(in: view), with: nil) as? UILabel else {
            view.endEditing(true)
            return
        }
    }
    
    @objc private func showMainScreen() {
        guard let text = nameField.text else { authButton.shake() ; return }
        guard !text.isEmpty else { authButton.shake() ; return }
        
    }

}

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
