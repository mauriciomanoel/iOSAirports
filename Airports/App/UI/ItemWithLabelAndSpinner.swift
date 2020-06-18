//
//  ItemWithLabelAndSpinner.swift
//  Airports
//
//  Created by Mauricio on 6/18/20.
//  Copyright © 2020 Mauricio. All rights reserved.
//

import UIKit

@IBDesignable
public class ItemWithLabelAndSpinner: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var dataTextField: UITextField!
    let datePicker = UIDatePicker()

    
    // Closures
    public var dataSelectedClosure: ((Int)->())?
    var valueSelectRowData: Int = 0
    var mData: [String] = []
    var barTintColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
    
    override init(frame aFrame: CGRect) {
        super.init(frame: aFrame)
        commomInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commomInit()
    }
    
    private func commomInit() {
        let bundle = Bundle(identifier: BUNDLE_IDENTIFIER)
        let nib = UINib(nibName: "ItemWithLabelAndSpinner", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateImages()
        addSubview(view)
    }
    
    public func setTitle(_ title: String?) {
        if let _title = title {
            self.titleLabel.text = _title
        }
    }
    
    public func setColorTitle(_ color: UIColor?) {
        if let _color = color {
            titleLabel.textColor = _color
        }
    }
    
    public func setPlaceHolder(_ placeHolder: String?) {
        if let _placeHolder = placeHolder {
            dataTextField.placeholder = _placeHolder
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        dataTextField.text = String(currentValue)
    }
    
    public func setupDropdownSpinner(_ data: [String]) {
        self.mData.removeAll()
        self.mData = data
        
        let cancelar = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onDismiss))
        let espaco = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let ok = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDone))
                
        let selectRowPickerClosure = {[weak self] in
            self!.valueSelectRowData = $0
        }
                        
        dataTextField.loadDropdownData(data: data, barButtonItems: [cancelar, espaco, ok], selectionHandler: selectRowPickerClosure, barTintColor: barTintColor)
    }
    
    
    public func setupDropdownDateSpinner() {
        self.mData.removeAll()

        let cancelar = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onDismiss))
        let espaco = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let ok = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneDate))

        //Formate Date
        datePicker.datePickerMode = .date

            //ToolBar
       let toolbar = UIToolbar();
       toolbar.sizeToFit()

       toolbar.setItems([cancelar, espaco, ok], animated: false)

        // add toolbar to textField
        dataTextField.inputAccessoryView = toolbar
         // add datepicker to textField
        dataTextField.inputView = datePicker
                
    }
    
    @objc func doneDate(){
      let formatter = DateFormatter()
      formatter.dateFormat = "MM/dd/yyyy"
      dataTextField.text = formatter.string(from: datePicker.date)
      dataTextField.resignFirstResponder()
    }
    
    @objc func onDismiss() {
        dataTextField.resignFirstResponder()
    }
    
    @objc func onDone() {
        dataTextField.resignFirstResponder()
        dataSelectedClosure?(valueSelectRowData)
        dataTextField.text = mData[valueSelectRowData]
    }
    
    public func updateImages() {
        let resourcePath = Bundle.main.resourcePath!
        let image = UIImage(contentsOfFile: URL(fileURLWithPath: resourcePath).appendingPathComponent("ic_calculate_arrow_down.png").path)
        if let _image = image {
            arrowImageView.image = _image
        }
    }
    
    public func setPlaceholder(placeholder: String?) {
        if let _placeholder = placeholder {
            dataTextField.attributedPlaceholder = NSAttributedString(string: _placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }
        
    public func resetData() {
       dataTextField.resignFirstResponder()
       valueSelectRowData = 0
       if (mData.count > 0) {
            dataTextField.text = mData[valueSelectRowData]
            setupDropdownSpinner(mData)
       }
    }
}
