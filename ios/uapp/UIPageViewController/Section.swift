//
//  Section.swift
//  Uapp
//
//  Created by EV Technologies Inc. on 2015-09-30.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import Foundation

// store section info
class Section {
    var users: [User] = []
    
    func addUser(user: User) {
        self.users.append(user)
    }
}