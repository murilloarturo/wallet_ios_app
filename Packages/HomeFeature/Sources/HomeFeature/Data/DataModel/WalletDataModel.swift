//
//  WalletDataModel.swift
//  
//
//  Created by Arturo Murillo on 26/5/24.
//

import UIKit

class WalletDataModel: Decodable {
    let accountId: String
    let iconURL: String
    let amount: AmountDataModel
    let creditType: String
    let dateTime: String
    
    enum CodingKeys: String, CodingKey {
        case accountId
        case iconURL
        case amount
        case creditType
        case dateTime = "datetime"
    }
}
