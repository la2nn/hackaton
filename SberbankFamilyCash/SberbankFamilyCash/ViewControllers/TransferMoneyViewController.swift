//
//  TransferMoneyViewController.swift
//  SberbankFamilyCash
//
//  Created by Николай Спиридонов on 16.11.2019.
//  Copyright © 2019 nnick. All rights reserved.
//

import UIKit

class TransferMoneyViewController: UIViewController {

    var cardMoney: Double! {
        didSet {
            title = String(cardMoney) + " ₽"
        }
    }
    var cardImage: UIImage!
    var cardNumber: Int!
    
    var tableView: UITableView!
    private var cellIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = String(cardMoney) + " ₽"
        
        let cardImageView = UIImageView()
        cardImageView.image = cardImage
        cardImageView.contentMode = .scaleAspectFit
        view.addSubview(cardImageView)
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        cardImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        cardImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        cardImageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.2).isActive = true
        cardImageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1).isActive = true
        
        let cardNumberLabel = UILabel()
        view.addSubview(cardNumberLabel)
        cardNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        cardNumberLabel.centerYAnchor.constraint(equalTo: cardImageView.centerYAnchor).isActive = true
        cardNumberLabel.leadingAnchor.constraint(equalTo: cardImageView.trailingAnchor).isActive = true
        cardNumberLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        cardNumberLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1).isActive = true

        cardNumberLabel.numberOfLines = 1
        cardNumberLabel.textAlignment = .center
        cardNumberLabel.font = UIFont.boldSystemFont(ofSize: 22)
        cardNumberLabel.textColor = .darkGray
        cardNumberLabel.text = "xxxx xxxx xxxx " + String(String(cardNumber).suffix(4))
        
        let transactionLabel = UILabel()
        view.addSubview(transactionLabel)
        transactionLabel.translatesAutoresizingMaskIntoConstraints = false
        transactionLabel.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: 20).isActive = true
        transactionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        transactionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        
        transactionLabel.numberOfLines = 2
        transactionLabel.textAlignment = .center
        transactionLabel.font = UIFont.boldSystemFont(ofSize: 22)
        transactionLabel.text = "Выберете семейный кошелек для пополнения"
        
        tableView = UITableView()
        tableView.backgroundColor = .white

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: transactionLabel.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(PiggyCell.self, forCellReuseIdentifier: PiggyCell.reuseID)
    }
    

    init(cardMoney: Double, cardImage: UIImage, cardNumber: Int, cellIndex: Int) {
        self.cardMoney = cardMoney
        self.cardImage = cardImage
        self.cardNumber = cardNumber
        self.cellIndex = cellIndex
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }

}

extension TransferMoneyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDataModel.shared.pigs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PiggyCell.reuseID, for: indexPath) as! PiggyCell
        cell.prepareForDataSetting()
        let currentPig = UserDataModel.shared.pigs[indexPath.row]
        cell.name = currentPig.name
        cell.haveMoney = currentPig.haveMoney
        cell.needMoney = currentPig.needMoney
        cell.selectionStyle = .gray
        return cell
    }
    
}

extension TransferMoneyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? PiggyCell else { return }
        let alert = UIAlertController(title: "Пополнение семейного кошелька", message: cell.name, preferredStyle: .alert)
        
        alert.addTextField { (field) in
            field.placeholder = "Сумма для перевода"
        }
        
        alert.addAction(UIAlertAction(title: "Пополнить", style: .default, handler: { (_) in
            if let requestSumString = alert.textFields?.first?.text, let requestSum = Double(requestSumString) {
                if requestSum > self.cardMoney {
                    return
                } else {
                    UserDataModel.shared.pigs[indexPath.row].haveMoney += requestSum
                    self.cardMoney -= requestSum
                    UserDataModel.shared.data[self.cellIndex].balance -= requestSum
                    self.dismiss(animated: true, completion: { tableView.reloadData() })
                }
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
}
