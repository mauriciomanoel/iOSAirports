//
//  UIView+Extension.swift
//  Airports
//
//  Created by Mauricio on 6/17/20.
//  Copyright © 2020 Mauricio. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    public var id: String? {
        get {
            return self.accessibilityIdentifier
        }
        set {
            self.accessibilityIdentifier = newValue
        }
    }

    public func getView(withId id: String) -> UIView? {
        if self.id == id {
            return self
        }
        for view in self.subviews {
            if let view = view.getView(withId: id) {
                return view
            }
        }
        return nil
    }
}
