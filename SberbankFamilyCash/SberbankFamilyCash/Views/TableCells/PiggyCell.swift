//
//  PiggyCell.swift
//  SberbankFamilyCash
//
//  Created by Николай Спиридонов on 16.11.2019.
//  Copyright © 2019 nnick. All rights reserved.
//

import UIKit

class PiggyCell: UITableViewCell {

    public static let reuseID = "PiggyCell"

    var view = UIView()
    var nameLabel = UILabel()
    var moneyLabel = UILabel()
    var progress = UIProgressView()

    var name: String? {
        set { nameLabel.text = newValue }
        get { return nameLabel.text }
    }
    
    var haveMoney: Double?
    
    var needMoney: Double? {
        set {
            moneyLabel.text = String(haveMoney ?? 0) + " / " + String(newValue ?? 0) + " ₽ "
            progress.setProgress(min(Float((haveMoney ?? 0) / (newValue ?? 0)), 1.0), animated: true)
            
        }
        get { return 0 }
    }
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        view.backgroundColor = #colorLiteral(red: 0.9210130572, green: 0.9253756404, blue: 0.9426833987, alpha: 1)
        self.contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        view.layoutIfNeeded()
        view.layer.cornerRadius = view.frame.height / 2
    }
    
    private func setMoneyLabel() {
        moneyLabel.font = UIFont.boldSystemFont(ofSize: 24)
        moneyLabel.textColor = #colorLiteral(red: 0.3671079278, green: 0.3765437603, blue: 0.376303494, alpha: 1)
        moneyLabel.numberOfLines = 1
        moneyLabel.textAlignment = .center
        
        view.addSubview(moneyLabel)
        moneyLabel.translatesAutoresizingMaskIntoConstraints = false
        moneyLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        moneyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        moneyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        moneyLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    private func setNameLabel() {
        nameLabel.font = UIFont.boldSystemFont(ofSize: 21)
        nameLabel.textColor = #colorLiteral(red: 0.1636615098, green: 0.1812741756, blue: 0.1883305311, alpha: 1)
        nameLabel.numberOfLines = 1
        nameLabel.textAlignment = .center
        
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    private func setProgressBar() {
        progress.progressViewStyle = .bar
        progress.backgroundColor = #colorLiteral(red: 1, green: 0.3844391108, blue: 0.3826514482, alpha: 1)
        progress.progressTintColor = .green
        progress.alpha = 0.6
        
        view.addSubview(progress)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.topAnchor.constraint(equalTo: moneyLabel.bottomAnchor, constant: 10).isActive = true
        progress.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        progress.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        progress.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.2).isActive = true
        
        progress.layer.cornerRadius = progress.frame.height
    }
    
    
    func prepareForDataSetting() {
        setNameLabel()
        setMoneyLabel()
        setProgressBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
