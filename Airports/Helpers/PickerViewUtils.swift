//
//  PickerViewCalculateUtils.swift
//  Airports
//
//  Created by Mauricio on 6/17/20.
//  Copyright © 2020 Mauricio. All rights reserved.
//

import Foundation
import UIKit

public class PickerViewUtils : UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate, UIToolbarDelegate {
    
    var pickerData : [String] = []
    var pickerTextField : UITextField!
    var selectRowPicker: ((Int)->())?
    let datePicker = UIDatePicker()
        
    init(pickerData: [String], barButtonItems: [UIBarButtonItem], dropdownField: UITextField, onSelect: ((Int)->())?, barTintColor: UIColor) {
        super.init(frame: CGRect.zero)
        
        self.pickerData = pickerData
        self.pickerTextField = dropdownField
        self.delegate = self
        self.dataSource = self
        
        if onSelect != nil {
            self.selectRowPicker = onSelect
        }
        
        let kbToolbar = UIToolbar()
        kbToolbar.delegate = self
        kbToolbar.barStyle = .default
        kbToolbar.tintColor = UIColor.white
        kbToolbar.sizeToFit()
        kbToolbar.barTintColor = barTintColor
        kbToolbar.setItems(barButtonItems, animated: true)
        kbToolbar.isUserInteractionEnabled = true
        self.pickerTextField.inputAccessoryView = kbToolbar
        
        DispatchQueue.main.async {
            if pickerData.count > 0 {
                self.pickerTextField.text = self.pickerData[0]
                self.pickerTextField.isEnabled = true
            } else {
                //self.pickerTextField.text = nil
                self.pickerTextField.isEnabled = false
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectRowPicker?(row)
    }

}
