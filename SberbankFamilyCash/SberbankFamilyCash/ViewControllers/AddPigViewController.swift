//
//  AddPigViewController.swift
//  SberbankFamilyCash
//
//  Created by Николай Спиридонов on 16.11.2019.
//  Copyright © 2019 nnick. All rights reserved.
//

import UIKit

class AddPigViewController: UIViewController {
    
    var nameField = CustomSizedTextField()
    var cashField = CustomSizedTextField()
    var bankUser: BankUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Создание нового кошелька"
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing(sender:))))

        let nameLabel = UILabel()
        nameLabel.text = "Введите параметры для семейной копилки"
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.15).isActive = true
        nameLabel.numberOfLines = 2
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.boldSystemFont(ofSize: 28)
        
        nameField.placeholder = "Введите имя / цель копилки"
        view.addSubview(nameField)
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        nameField.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
        nameField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        nameField.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1).isActive = true
        nameField.layoutIfNeeded()
        
        nameField.layer.cornerRadius = nameField.frame.height / 3
        nameField.backgroundColor = #colorLiteral(red: 0.9210130572, green: 0.9253756404, blue: 0.9426833987, alpha: 1)
        nameField.delegate = self
        
        cashField.placeholder = "Введите необходимую сумму"
        view.addSubview(cashField)
        cashField.translatesAutoresizingMaskIntoConstraints = false
        cashField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20).isActive = true
        cashField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor).isActive = true
        cashField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor).isActive = true
        cashField.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1).isActive = true
        cashField.layoutIfNeeded()
        
        cashField.layer.cornerRadius = nameField.frame.height / 3
        cashField.backgroundColor = #colorLiteral(red: 0.9210130572, green: 0.9253756404, blue: 0.9426833987, alpha: 1)
        cashField.delegate = self
        
        let continueButton = UIButton(type: .system)
        continueButton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        continueButton.setTitle("Продолжить", for: .normal)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
        view.addSubview(continueButton)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        continueButton.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        continueButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        continueButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1).isActive = true
        continueButton.layoutIfNeeded()
        continueButton.layer.cornerRadius = continueButton.frame.height / 3
    }
    
    init(bankUser: BankUser) {
        self.bankUser = bankUser
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc private func endEditing(sender: UITapGestureRecognizer) {
        guard let _ = view.hitTest(sender.location(in: view), with: nil) as? UILabel else {
            view.endEditing(true)
            return
        }
    }
    
    @objc private func continueButtonPressed() {
        if nameField.text!.isEmpty { nameField.shake() ; return }
        guard let text = cashField.text else { cashField.shake() ; return }
        guard let cash = Double(text) else { cashField.shake() ; return }
        if !text.isEmpty {
            self.navigationController?.pushViewController(ContactsSelectionViewController(cash: cash, name: nameField.text!, bankUser: bankUser), animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(pop))
    }
    
    @objc private func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension AddPigViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
         textField.resignFirstResponder()
         return true
     }
}
