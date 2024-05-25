//
//  Item.swift
//  WalletApp
//
//  Created by Arturo Murillo on 25/5/24.
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
