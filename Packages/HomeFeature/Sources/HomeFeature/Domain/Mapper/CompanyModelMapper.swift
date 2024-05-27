//
//  CompanyModelMapper.swift
//
//
//  Created by Arturo Murillo on 26/5/24.
//

import Common
import Localization

struct CompanyModelMapper: Mapping {
    typealias Mapper = any Mapping<Input, Output>
    
    func map(_ input: CompanyDataModel) -> CompanyModel {
        .init(name: input.name,
              wallets: input.wallets.map { mapWallet($0) })
    }
    
    private func mapWallet(_ input: WalletDataModel) -> WalletModel {
        .init(id: input.accountId,
              name: input.amount.currency,
              iconURL: input.iconURL,
              amount: .init(amount: input.amount.amount))
    }
}
