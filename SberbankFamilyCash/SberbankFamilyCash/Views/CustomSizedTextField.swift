//
//  CustomSizedTextField.swift
//  SberbankFamilyCash
//
//  Created by Николай Спиридонов on 16.11.2019.
//  Copyright © 2019 nnick. All rights reserved.
//

import UIKit

class CustomSizedTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 10, dy: 0)
    }

}
