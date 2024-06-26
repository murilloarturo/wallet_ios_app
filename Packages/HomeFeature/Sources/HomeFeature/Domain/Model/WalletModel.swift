//
//  File.swift
//  
//
//  Created by Arturo Murillo on 26/5/24.
//

import Foundation

struct WalletModel: Equatable {
    struct Amount: Equatable {
        let amount: Double
    }
    
    let id: String
    let name: String
    let iconURL: String
    let amount: Amount
}
