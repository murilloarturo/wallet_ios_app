//
//  CompanyErrorMapper.swift
//  
//
//  Created by Arturo Murillo on 26/5/24.
//

import Common
import Network

struct CompanyErrorMapper: Mapping {
    typealias Mapper = any Mapping<Input, Output>
    
    func map(_ input: Error) -> CompanyError {
        if let networkError = input as? NetworkError {
            return networkError == .noConnection ? .noConnection : .generic
        } else {
            return .generic
        }
    }
}
