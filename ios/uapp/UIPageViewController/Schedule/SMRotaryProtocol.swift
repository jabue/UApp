//
//  SMRotaryProtocol.swift
//  
//
//  Created by zhaofei on 2015-09-21.
//
//

import Foundation
import UIKit

protocol SMRotaryProtocol {
    
    // protocol definition goes here
    func wheelDidChangeValue(newValue: Int) -> Void
    func courseSelected(course: String) -> Void
}

