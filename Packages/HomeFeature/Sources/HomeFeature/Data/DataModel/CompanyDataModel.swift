//
//  CompanyDataModel.swift
//  
//
//  Created by Arturo Murillo on 26/5/24.
//

import Foundation

struct CompanyDataModel: Decodable {
    let name: String
    let wallets: [WalletDataModel]
}
