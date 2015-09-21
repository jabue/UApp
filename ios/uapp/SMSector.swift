//
//  SMSector.swift
//  
//
//  Created by zhaofei on 2015-09-21.
//
//

import Foundation

class SMSector: NSObject {
    var minValue: Float = 0.0
    var maxValue: Float = 0.0
    var midValue: Float = 0.0
    var sector: Int = 0
    
    private func description() ->NSString{
        return String(format: "%i | %f, %f, %f", self.sector, self.minValue, self.midValue, self.maxValue)
    }
    
    override init() {
        return
    }
    
}
