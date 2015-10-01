//
//  User.swift
//  Uapp
//
//  Created by EV Technologies Inc. on 2015-09-30.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import Foundation

// to store user information
class User: NSObject {
    var name: String
    var image: UIImage?
    var insection: Int?
    
    init(name: String) {
        self.name = name
    }
}