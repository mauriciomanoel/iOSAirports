//
//  ExtensionUITextField.swift
//  Airports
//
//  Created by Mauricio on 6/17/20.
//  Copyright © 2020 Mauricio. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {

    public func loadDropdownData(data: [String], barButtonItems: [UIBarButtonItem], selectionHandler: ((Int)->())?, barTintColor: UIColor = UIColor(red: 0/255, green: 137/255, blue: 255/255, alpha: 1.0)) {
        self.inputView = PickerViewUtils(pickerData: data, barButtonItems: barButtonItems, dropdownField: self, onSelect: selectionHandler, barTintColor: barTintColor)
    }
    
}
