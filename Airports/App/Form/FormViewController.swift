//
//  FormViewController.swift
//  Airports
//
//  Created by Mauricio on 6/17/20.
//  Copyright © 2020 Mauricio. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {

    lazy var mainView: FormView = {
        return self.view.getView(withId: "mainView") as! FormView
    }()
    
    lazy var viewModel : FormViewModel = {
        return FormViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        beforeListeners()
        mainView.setupLayout()

        // Do any additional setup after loading the view.
        
        viewModel.loadParametersClosure = {[weak self] (value) in
            DispatchQueue.main.async {
                if let _self = self {
                    if (value) {
                        _self.afterListeners()
                    }
                }
            }
        }
    }
    
    
    func beforeListeners() {
            
        viewModel.isLoadingClosure = {[weak self] (value) in
            DispatchQueue.main.async {
                if let _self = self {
                    if (value) {
                        _self.mainView.showLoading()
                    } else {
                        _self.mainView.hideLoading()
                    }
                }
            }
        }
        
        viewModel.passengersAdultsClosure = {[weak self] (values) in
            DispatchQueue.main.async {
                if let _self = self {
                    _self.mainView.setDataPassengersAdults(values)
                }
            }
        }
        
        viewModel.passengersTeensClosure = {[weak self] (values) in
            DispatchQueue.main.async {
                if let _self = self {
                    _self.mainView.setDataPassengersTeens(values)
                }
            }
        }
        
        viewModel.passengersChildrenClosure = {[weak self] (values) in
            DispatchQueue.main.async {
                if let _self = self {
                    _self.mainView.setDataPassengersChildren(values)
                }
            }
        }
        
        viewModel.showErrorMessageClosure = {[weak self] (value) in
            DispatchQueue.main.async {
                
                if let _self = self {
                    let alert = UIAlertController(title: "Alert", message: value, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
                    _self.present(alert, animated: true)
                }
                
                
            }
        }
        
        viewModel.loadParameters()
        
    }
    
    
    func afterListeners() {
        mainView.flightInputClosure = {[weak self] (value) in
            DispatchQueue.main.async {
                if let _self = self {
                    _self.viewModel.searchFlights(value)
                }
            }
        }
        
        
        viewModel.flightsClosure = {[weak self] (value) in
            DispatchQueue.main.async {
                if let _self = self {
                    _self.performSegue(withIdentifier: "showResult", sender: self)
                }
            }
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showResult" {
            if let destinationVC = segue.destination as? SearchFlightsViewController {
                destinationVC.flightsResult = viewModel.flightsResult
            }
        }
        
        print("prepare")
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
