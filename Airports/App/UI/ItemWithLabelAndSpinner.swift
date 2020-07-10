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
    public var dateFormat = "dd/MM/yyyy"
    public var minimumDate:Date?
    public var maximumDate:Date?

    // Closures
    public var dataSelectedClosure: ((Int)->())?
    public var dateSelectedClosure: ((String?)->())?
    var valueSelectRowData: Int = 0
    var mData: [String] = []
    var barTintColor = UIColor(red: 7/255, green: 53/255, blue: 144/255, alpha: 1.0)
    
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

        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        minimumDate = dateFormatterGet.date(from: "2020-07-02")
        maximumDate = dateFormatterGet.date(from: "2021-07-02")

        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.minimumDate = self.minimumDate
        datePicker.maximumDate = self.maximumDate

       //ToolBar
       let toolbar = UIToolbar();
       toolbar.barStyle = .default
       toolbar.tintColor = UIColor.white
       toolbar.sizeToFit()
       toolbar.barTintColor = barTintColor
       toolbar.setItems([cancelar, espaco, ok], animated: false)

        // add toolbar to textField
        dataTextField.inputAccessoryView = toolbar
         // add datepicker to textField
        dataTextField.inputView = datePicker
                
    }
    
    @objc func doneDate(){
      let formatter = DateFormatter()
      formatter.dateFormat = dateFormat
      dataTextField.text = formatter.string(from: datePicker.date)
      dateSelectedClosure?(dataTextField.text)
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
        let image = UIImage(contentsOfFile: URL(fileURLWithPath: resourcePath).appendingPathComponent("ic_arrow_down.png").path)
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
