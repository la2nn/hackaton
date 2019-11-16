//
//  BankAccountsModel.swift
//  SberbankFamilyCash
//
//  Created by Николай Спиридонов on 16.11.2019.
//  Copyright © 2019 nnick. All rights reserved.
//

import Foundation

struct BankAccountModel: Decodable {
    let data: [String: [UserAccountModel]]
}

struct UserAccountModel: Decodable {
    let userInfo: [[UserEntitiesModel]]
}

struct UserEntitiesModel: Decodable {
    let entitiesInfo: [String: String]
}

