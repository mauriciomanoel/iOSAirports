//
//  CustomSearchTextField.swift
//  Airports
//
//  Created by Mauricio on 6/18/20.
//  Copyright © 2020 Mauricio. All rights reserved.
//

import UIKit

class CustomSearchTextField: UITextField {

    var dataList : [Countries] = [Countries]()
    var resultsList : [CountrySearchItem] = [CountrySearchItem]()
    var tableView: UITableView?
                
    // Connecting the new element to the parent view
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        tableView?.removeFromSuperview()
        
    }
    
    override open func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        self.addTarget(self, action: #selector(CustomSearchTextField.textFieldDidChange), for: .editingChanged)
    }
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        buildSearchTableView()
        
    }
    
    
    //////////////////////////////////////////////////////////////////////////////
    // Text Field related methods
    //////////////////////////////////////////////////////////////////////////////
    
    @objc open func textFieldDidChange(){
        filter()
        updateSearchTableView()
        tableView?.isHidden = false
    }
    
    // MARK: Filtering methods
    
    fileprivate func filter() {
        
        resultsList = []
        
        for i in 0 ..< dataList.count {
            
            let item = CountrySearchItem(countryCode: dataList[i].countryCode, countryName: dataList[i].countryName, stationCode: dataList[i].stationCode, stationName: dataList[i].stationName)

            let filterRange = (item.getStringText() as NSString).range(of: text!, options: .caseInsensitive)

            if filterRange.location != NSNotFound {
                item.attributedStationName = NSMutableAttributedString(string: item.stationName)
                item.attributedCountryCode = NSMutableAttributedString(string: item.countryCode)
                item.attributedCountryName = NSMutableAttributedString(string: item.countryName)
                item.getFormatedText()
                item.allAttributedName!.setAttributes([.font: UIFont.boldSystemFont(ofSize: 17)], range: filterRange)
                resultsList.append(item)
            }

        }
        
        tableView?.reloadData()
    }
    

}

extension CustomSearchTextField: UITableViewDelegate, UITableViewDataSource {
    

    //////////////////////////////////////////////////////////////////////////////
    // Table View related methods
    //////////////////////////////////////////////////////////////////////////////
    
    
    // MARK: TableView creation and updating
    
    // Create SearchTableview
    func buildSearchTableView() {

        if let tableView = tableView {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CustomSearchTextFieldCell")
            tableView.delegate = self
            tableView.dataSource = self
            self.window?.addSubview(tableView)

        } else {
            addData()
            tableView = UITableView(frame: CGRect.zero)
        }
        
        updateSearchTableView()
    }
    
    // Updating SearchtableView
    func updateSearchTableView() {
        
        if let tableView = tableView {
            superview?.bringSubviewToFront(tableView)
            var tableHeight: CGFloat = 0
            tableHeight = tableView.contentSize.height
            
            // Set a bottom margin of 10p
            if tableHeight < tableView.contentSize.height {
                tableHeight -= 10
            }
            
            // Set tableView frame
            var tableViewFrame = CGRect(x: 0, y: 0, width: frame.size.width - 4, height: tableHeight)
            tableViewFrame.origin = self.convert(tableViewFrame.origin, to: nil)
            tableViewFrame.origin.x += 2
            tableViewFrame.origin.y += frame.size.height + 2
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.tableView?.frame = tableViewFrame
            })
            
            //Setting tableView style
            tableView.layer.masksToBounds = true
            tableView.separatorInset = UIEdgeInsets.zero
            tableView.layer.cornerRadius = 5.0
            tableView.separatorColor = UIColor.lightGray
            tableView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
            
            if self.isFirstResponder {
                superview?.bringSubviewToFront(self)
            }
            
            tableView.reloadData()
        }
    }
    
    // MARK: TableViewDataSource methods
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsList.count
    }
    
    // MARK: TableViewDelegate methods
    
    //Adding rows in the tableview with the data from dataList
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomSearchTextFieldCell", for: indexPath) as UITableViewCell
        cell.backgroundColor = UIColor.white
        cell.textLabel?.attributedText = resultsList[indexPath.row].allAttributedName
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.text = resultsList[indexPath.row].getStringText()
        tableView.isHidden = true
        self.endEditing(true)
    }
    

    // MARK: Early testing methods
    func addData(){
        
        if let countries = AppController.countriesList {
            dataList = countries
        }
    }
    
}
