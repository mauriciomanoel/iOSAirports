//
//  HTTPTask.swift
//  Airports
//
//  Created by Mauricio on 6/18/20.
//  Copyright © 2020 Mauricio. All rights reserved.
//

import Foundation

public enum HTTPTask {
    case request(data : Data, query : Dictionary<String, String>, headers : Dictionary<String, String>)
}
