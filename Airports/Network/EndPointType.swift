//
//  EndPointType.swift
//  Airports
//
//  Created by Mauricio on 6/18/20.
//  Copyright © 2020 Mauricio. All rights reserved.
//

import Foundation

public protocol EndPointType {
    var completeURL : URL        { get }
    var httpMethod  : HTTPMethod { get }
    var task        : HTTPTask   { get }
}
