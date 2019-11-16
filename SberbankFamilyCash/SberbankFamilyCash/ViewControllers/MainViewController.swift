//
//  MainViewController.swift
//  SberbankFamilyCash
//
//  Created by Николай Спиридонов on 16.11.2019.
//  Copyright © 2019 nnick. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView = UITableView()
        tableView.backgroundColor = .white

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        
        title = "Личный кабинет"

        tableView.register(CardCell.self, forCellReuseIdentifier: CardCell.reuseID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(showRoot))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCard))
        
    }
    
    @objc private func showRoot() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func addCard() {
        tableView.performBatchUpdates({
            UserDataModel.shared.data.append(UserDataModel.getRandomCard())
            tableView.insertRows(at: [IndexPath(row: UserDataModel.shared.data.count - 1, section: 0)], with: .automatic)
        }, completion: nil)
    }
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return UserDataModel.shared.data.count
        case 1: return 1
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.reuseID, for: indexPath) as! CardCell
            let cellData = UserDataModel.shared.data[indexPath.row]
            cell.cardLogo = cellData.cardType
            cell.cardBalance = cellData.balance
            cell.cardNumber = cellData.cardNumber
            cell.selectionStyle = .none
            return cell
            
        case 1:
            return  UITableViewCell()
            
            
            
            
        default: return UITableViewCell()
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0: return "Карты"
            case 1: return "Семейные кошельки"
            default: return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        backView.backgroundColor = .white
        backView.alpha = 0.95
        
        let title = CustomSizedLabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width - 10, height: 60))
        title.font = UIFont.boldSystemFont(ofSize: 34)
        title.numberOfLines = 1
        switch section {
        case 0: title.text = "Карты"
        case 1: title.text = "Семейные кошельки"
        default: break
        }
        
        backView.addSubview(title)
        
        return backView
    }
}
