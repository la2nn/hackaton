//
//  BankAccountsModel.swift
//  SberbankFamilyCash
//
//  Created by Николай Спиридонов on 16.11.2019.
//  Copyright © 2019 nnick. All rights reserved.
//

import Foundation

class BankUser {
    let name: String
    var cards = [Card]()
    var purses = [Purse]()
    
    init(name: String, cards: [Card] = [Card](), purses: [Purse] = [Purse]()) {
        self.name = name
        self.purses = purses
        self.cards = cards
    }
    
    static func getBank(user: String) -> BankUser {
        guard let person = UserDefaults.standard.object(forKey: user) as? [String : [[String : String]]] else {
            return BankUser(name: user)
        }
            var myPurses = [Purse]()
            var myCards = [Card]()
            
            if let cards = person["Карты"] {
                cards.forEach { if let number = $0["Номер"],
                    let balance = $0["Баланс"],
                    let type = $0["Тип"] {
                    var card = Card()
                    card.cardNumber = Int(number)!
                    card.balance = Double(balance)!
                    card.cardType = CardLogo(rawValue: type)
                    myCards.append(card)
                    }
                }
            }
        
        if let unwrappedPurses = UserDefaults.standard.value(forKey: "Копилки") as? [[String : String]] {
            for purse in unwrappedPurses {
                let isUserAccepted: Bool
                if purse["Пользователи"]!.contains("/") {
                    isUserAccepted = (purse["Пользователи"]?.components(separatedBy: "/").contains(user))!
                } else {
                    isUserAccepted = (purse["Пользователи"]!.contains(user))
                }
                if isUserAccepted {
                    if let name = purse["Имя"], let haveMoney = purse["Имеется"], let needMoney = purse["Необходимо"] {
                         if purse["Пользователи"]!.contains("/") {
                        myPurses.append(Purse(name: name, haveMoney: Double(haveMoney)!, needMoney: Double(needMoney)!, allowsForUsers: purse["Пользователи"]!.components(separatedBy: "/")))
                         } else {
                            myPurses.append(Purse(name: name, haveMoney: Double(haveMoney)!, needMoney: Double(needMoney)!, allowsForUsers: [purse["Пользователи"]!]))
                        }
                    }
                    
                }
            }
        }
        
        return BankUser(name: user, cards: myCards, purses: myPurses)
    }
        
    
    static func set(card: Card, for person: String) -> [String : [[String : String]]] {
        let number = String(card.cardNumber)
        let balance = String(card.balance)
        let type = card.cardType.rawValue
        
        if let _ = UserDefaults.standard.object(forKey: person) as? [String : [[String : String]]] {
            return ["Карты" : [["Номер" : number, "Баланс" : balance, "Тип" : type]] + getCurrentCards(person: person)!]
        } else {
            return ["Карты" : [["Номер" : number, "Баланс" : balance, "Тип" : type]]]
        }
    }
        
    static func getCurrentCards(person: String) -> [[String : String]]? {
        guard let person = UserDefaults.standard.object(forKey: person) as? [String : [[String : String]]] else {
            return nil
        }
        var result = [[String : String]]()
        if let cards = person["Карты"] {
            cards.forEach { if let number = $0["Номер"],
                let balance = $0["Баланс"],
                let type = $0["Тип"] {
                result.append(["Номер": number, "Баланс": balance, "Тип": type])
                }
            }
        } else { return nil }
        return result
    }
    
    func setCardsIntoUserDefaultsFromCurrentBank() {
        guard UserDefaults.standard.object(forKey: self.name) as? [String : [[String : String]]] != nil else {
            return
        }
        
        var result = [[String : String]]()
        cards.forEach {
            let number = String($0.cardNumber)
            let balance = String($0.balance)
            let type = $0.cardType.rawValue
            result.append(["Номер": number, "Баланс": balance, "Тип": type])
        }
        
        UserDefaults.standard.setValue(["Карты" : result], forKey: self.name)
    }
    
    func setPursesIntoUserDefaultsFromCurrentBank() {
        var result = [[String : String]]()
        for purse in self.purses {
            let name = purse.name
            let haveMoney = String(purse.haveMoney)
            let needMoney = String(purse.needMoney)
            let users: String
            if purse.allowsForUsers.count == 1 {
                users = purse.allowsForUsers.first!
            } else {
                users = purse.allowsForUsers.joined(separator: "/")
            }
            result.append(["Имя" : name!, "Имеется" : haveMoney, "Необходимо" : needMoney, "Пользователи" : users])
        }
        
        if let purses = UserDefaults.standard.object(forKey: "Копилки") as? [[String : String]] {
            UserDefaults.standard.set(result + purses, forKey: "Копилки")
        } else {
            UserDefaults.standard.set(result, forKey: "Копилки")
        }
            
    }
}

struct Card {
    var balance: Double!
    var cardNumber: Int!
    var cardType: CardLogo!
    
    static func getRandomCard() -> Card {
        let names = ["visa", "master"]
        return Card(balance: Double(Int.random(in: 2210...150000)), cardNumber: Int.random(in: 1111111111111111...9999999999999999), cardType: CardLogo(rawValue: names.randomElement()!))
        
    }
}

struct Purse {
    var name: String!
    var haveMoney: Double!
    var needMoney: Double!
    var allowsForUsers: [String]
}


