//
//  CustomSizedLabel.swift
//  SberbankFamilyCash
//
//  Created by Николай Спиридонов on 16.11.2019.
//  Copyright © 2019 nnick. All rights reserved.
//

import UIKit

class CustomSizedLabel: UILabel {

   override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
        super.drawText(in: rect.inset(by: insets))
    }
    
}
