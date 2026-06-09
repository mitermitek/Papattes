//
//  Item.swift
//  Papattes
//
//  Created by Kevin MITERMITE on 09/06/2026.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
