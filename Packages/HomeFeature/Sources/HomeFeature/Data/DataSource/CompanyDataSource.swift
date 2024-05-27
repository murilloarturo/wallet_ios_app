//
//  CompanyDataSource.swift
//
//
//  Created by Arturo Murillo on 26/5/24.
//

import Foundation
import Common

protocol CompanyDataSource {
    func getCompany() async -> Result<CompanyModel, CompanyError>
}

final class CompanyRemoteDataSource: CompanyDataSource {
    private let apiClient: APIClienting
    private let companyModelMapper: CompanyModelMapper.Mapper
    private let companyErrorMapper: CompanyErrorMapper.Mapper

    init(apiClient: APIClienting,
         companyModelMapper: CompanyModelMapper.Mapper,
         companyErrorMapper: CompanyErrorMapper.Mapper) {
        self.apiClient = apiClient
        self.companyModelMapper = companyModelMapper
        self.companyErrorMapper = companyErrorMapper
    }

    static func buildDefault() -> Self {
        .init(apiClient: APIClient.buildDefault(),
              companyModelMapper: CompanyModelMapper(),
              companyErrorMapper: CompanyErrorMapper())
    }

    func getCompany() async -> Result<CompanyModel, CompanyError> {
        do {
            return try await apiClient.fetchCompany()
                .map { dataModel in
                    companyModelMapper.map(dataModel)
                }
                .mapError { error in
                    companyErrorMapper.map(error)
                }
        } catch {
            return .failure(companyErrorMapper.map(error))
        }
    }
}
