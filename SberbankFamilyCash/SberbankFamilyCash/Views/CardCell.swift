//
//  CardCell.swift
//  SberbankFamilyCash
//
//  Created by Николай Спиридонов on 16.11.2019.
//  Copyright © 2019 nnick. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {
    
    public static let reuseID = "CardCell"
    private var view: UIView!
    var cardImageView: UIImageView!
    var cardLogo: CardLogo! {
        didSet {
            setupCardLogo()
        }
    }
    
    var cardBalance: Double! {
       didSet {
            setBalance()
        }
    }
    
    var cardNumber: Int! {
       didSet {
            setCardNumber()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: CardCell.reuseID)
        
        view = UIView()
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
    
    private func setBalance() {
        let balanceLabel = UILabel()
        balanceLabel.text = String(cardBalance) + " Р"
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(balanceLabel)
        balanceLabel.leadingAnchor.constraint(equalTo: cardImageView.trailingAnchor, constant: 20).isActive = true
        balanceLabel.centerYAnchor.constraint(equalTo: cardImageView.centerYAnchor).isActive = true
        balanceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        balanceLabel.heightAnchor.constraint(equalTo: cardImageView.heightAnchor).isActive = true
        balanceLabel.numberOfLines = 1
        balanceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        balanceLabel.textAlignment = .right
    }
    
    private func setCardNumber() {
        let cardNumberLabel = UILabel()
        cardNumberLabel.text = String(cardNumber)
        cardNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cardNumberLabel)
        cardNumberLabel.leadingAnchor.constraint(equalTo: cardImageView.leadingAnchor, constant: 10).isActive = true
        cardNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive = true
        cardNumberLabel.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: 5).isActive = true
        cardNumberLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true

        cardNumberLabel.numberOfLines = 1
        cardNumberLabel.font = UIFont.boldSystemFont(ofSize: 18)
        cardNumberLabel.textColor = .darkGray
        
        cardNumberLabel.text = "xxxx xxxx xxxx " + String(String(cardNumber).suffix(4))
        
    }
    
    private func setupCardLogo() {
        cardImageView = UIImageView(image: UIImage(named: cardLogo.rawValue))
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cardImageView)
        cardImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        cardImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        cardImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15).isActive = true
        cardImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        cardImageView.contentMode = .scaleAspectFit
        cardImageView.layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
