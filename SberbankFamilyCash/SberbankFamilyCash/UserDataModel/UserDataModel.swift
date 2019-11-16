//
//  File.swift
//  SberbankFamilyCash
//
//  Created by Николай Спиридонов on 16.11.2019.
//  Copyright © 2019 nnick. All rights reserved.
//

import Foundation

struct UserDataModel {
    struct Card {
        var balance: Double
        var cardNumber: Int
        var cardType: CardLogo
    }
    
    func getCards(userName: String) -> [Card]? {
        guard let userCards = UserDefaults.standard.object(forKey: userName) as? [[String : String]] else { return nil }
        var cards = [Card]()
        for card in userCards {
           
            cards.append(Card(balance: Double(card["balance"]!) ?? 0, cardNumber: Int(card["cardNumber"]!) ?? 1111, cardType: CardLogo(rawValue: card["cardType"]!)!))
        }
        
        return cards
    }
    
    var data = [getRandomCard(), getRandomCard(), getRandomCard(), getRandomCard(), getRandomCard()]
    
    static func getRandomCard() -> Card {
        return Card(balance: Double(Int.random(in: 2210...7362178)), cardNumber: Int.random(in: 1111111111111111...9999999999999999), cardType: CardLogo(rawValue: UserDataModel.getRandomCardName())!)
    }
    
    static func getRandomCardName() -> String {
        let names = ["mir", "visa", "master"]
        return names.randomElement()!
    }

    
    public static var shared = UserDataModel()
    
    private init() { }
}


