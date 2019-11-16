//
//  ContactsSelectionViewController.swift
//  SberbankFamilyCash
//
//  Created by Николай Спиридонов on 16.11.2019.
//  Copyright © 2019 nnick. All rights reserved.
//

import UIKit

class ContactsSelectionViewController: UIViewController {
    
    private var tableView = UITableView()
    var cash: Double?
    var name: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        let infoLabel = UILabel()
        infoLabel.text = "Добавьте контакты к этому кошельку"
        view.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        infoLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.15).isActive = true
        infoLabel.numberOfLines = 2
        infoLabel.textAlignment = .left
        infoLabel.font = UIFont.boldSystemFont(ofSize: 28)
        
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
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -10).isActive = true
        
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        tableView.backgroundColor = .white
        tableView.rowHeight = 100
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.reuseID)
    }
    
    @objc private func continueButtonPressed() {
        UserDataModel.shared.pigs.append(UserDataModel.Piggy(name: name ?? "", haveMoney: 0, needMoney: cash ?? 0))
        if let mainVC = navigationController!.viewControllers[1] as? MainViewController {
           // tableView.indexPathsForSelectedRows
            self.navigationController?.popToViewController(mainVC, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Пропустить", style: .plain, target: self, action: #selector(skip))
    }
    
    @objc private func skip() {
        UserDataModel.shared.pigs.append(UserDataModel.Piggy(name: name ?? "", haveMoney: 0, needMoney: cash ?? 0))
        if let mainVC = navigationController!.viewControllers[1] as? MainViewController {
            self.navigationController?.popToViewController(mainVC, animated: true)
        }
    }
    
    init(cash: Double, name: String) {
         self.cash = cash
         self.name = name
         super.init(nibName: nil, bundle: nil)
     }
     
     public required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
     }
}

extension ContactsSelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.reuseID, for: indexPath)
        cell.imageView?.image = String.randomEmoji().image()
        cell.imageView?.contentMode = .center
        cell.textLabel?.text = "Мама"
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        return cell
    }
  
}
