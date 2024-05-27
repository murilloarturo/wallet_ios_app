//
//  GetCompany.swift
//
//
//  Created by Arturo Murillo on 26/5/24.
//

import Foundation

protocol GetCompanyUseCase {
    func execute() async -> Result<CompanyModel, CompanyError>
}

final class GetCompany: GetCompanyUseCase {
    let dataSource: CompanyDataSource
    
    static func buildDefault() -> Self {
        .init(dataSource: CompanyRemoteDataSource.buildDefault())
    }
    
    init(dataSource: CompanyDataSource) {
        self.dataSource = dataSource
    }
    
    func execute() async -> Result<CompanyModel, CompanyError> {
        await dataSource.getCompany()
    }
}
