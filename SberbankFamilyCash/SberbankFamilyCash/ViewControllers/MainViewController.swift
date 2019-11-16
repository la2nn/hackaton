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
        tableView.register(PiggyCell.self, forCellReuseIdentifier: PiggyCell.reuseID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(showRoot))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCard))
        
        if tableView != nil {
            tableView.reloadData()
        }
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return UserDataModel.shared.data.count
        case 1: return UserDataModel.shared.pigs.count
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
            let cell = tableView.dequeueReusableCell(withIdentifier: PiggyCell.reuseID, for: indexPath) as! PiggyCell
            let currentPig = UserDataModel.shared.pigs[indexPath.row]
            cell.name = currentPig.name
            cell.haveMoney = currentPig.haveMoney
            cell.needMoney = currentPig.needMoney
            cell.selectionStyle = .none
            return cell
            
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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 40
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            let backView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
            backView.backgroundColor = .white
            
            let addPigButton = UIButton(type: .contactAdd)
            addPigButton.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40)
            addPigButton.setTitle(" Добавить копилку", for: .normal)
            addPigButton.addTarget(self, action: #selector(shopAddPigController), for: .touchUpInside)
            addPigButton.backgroundColor = .clear
            backView.addSubview(addPigButton)
            backView.alpha = 0.9
            
            return backView
        }
        return nil
    }
    
    @objc private func shopAddPigController() {
        navigationController?.pushViewController(AddPigViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            guard let cell = tableView.cellForRow(at: indexPath) as? CardCell else { return }
            let transferMoneyVC = TransferMoneyViewController(cardMoney: cell.cardBalance, cardImage: cell.cardImageView.image ?? #imageLiteral(resourceName: "sberLogo"), cardNumber: cell.cardNumber)
            navigationController?.pushViewController(transferMoneyVC, animated: true)
        }
    }
}
