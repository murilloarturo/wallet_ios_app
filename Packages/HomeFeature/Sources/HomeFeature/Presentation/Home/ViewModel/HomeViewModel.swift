//
//  HomeViewModel.swift
//
//
//  Created by Arturo Murillo on 26/5/24.
//

import Foundation
import Combine
import DesignSystem
import Localization

public final class HomeViewModel: ObservableObject {
    struct State {
        var isLoading: Bool
        var selectedTab: HomeTab
        var tabs: [HomeTab]
        var isViewExpanded: Bool
        var company: CompanyModel?
        var error: CompanyError?
        
        init(selectedTab: HomeTab,
             tabs: [HomeTab],
             isLoading: Bool = false,
             isViewExpanded: Bool = false,
             company: CompanyModel? = nil,
             error: CompanyError? = nil) {
            self.isLoading = isLoading
            self.selectedTab = selectedTab
            self.tabs = tabs
            self.isViewExpanded = isViewExpanded
            self.company = company
            self.error = error
        }
    }
    
    enum HomeAction {
        case selectTab(index: Int)
        case expandContainer(expanded: Bool)
    }
    
    private var state: State
    private let mapper: HomeViewModelPresentationMapper.Mapper
    private let getCompanyUseCase: GetCompanyUseCase

    @Published public var presentation: HomeViewModelPresentation
    @Published public var isContainerExpanded: Bool = false
    @Published public var selectedTabIndex: Int = 0
    @Published public var scrollViewOffset: CGPoint = CGPoint(x: 0, y: 0)
    
    private var cancellables = Set<AnyCancellable>()
    
    static func buildDefault() -> Self {
        .init(state: State(selectedTab: .home,
                           tabs: [.home, .products]),
              mapper: HomeViewModelPresentationMapper.buildDefault(),
              getCompanyUseCase: GetCompany.buildDefault())
    }
    
    init(state: State,
         mapper: HomeViewModelPresentationMapper.Mapper,
         getCompanyUseCase: GetCompanyUseCase) {
        self.state = state
        self.mapper = mapper
        self.getCompanyUseCase = getCompanyUseCase
        self.presentation = mapper.map(state)
        
        bind()
    }
    
    private func bind() {
        $selectedTabIndex
            .sink(receiveValue: { [weak self] newValue in
                self?.handle(.selectTab(index: newValue))
            })
            .store(in: &cancellables)
        
        $isContainerExpanded
            .sink(receiveValue: { [weak self] newValue in
                self?.handle(.expandContainer(expanded: newValue))
            })
            .store(in: &cancellables)
    }
    
    func handle(_ action: HomeAction) {
        switch action {
        case .selectTab(let index):
            guard let tab = state.tabs[safe: index] else { return }
            state.selectedTab = tab
            state.isViewExpanded = false
            emit()
            break
        case .expandContainer(let expanded):
            state.isViewExpanded = expanded
            emit()
            break
        }
    }
    
    func fetchCompany() async {
        state.isLoading = true
        emit()
        let companyResult = await getCompanyUseCase.execute()
        switch companyResult {
        case .success(let model):
            state.company = model
        case .failure(let error):
            state.error = error
        }
        state.isLoading = false
        emit()
    }
    
    private func emit() {
        DispatchQueue.main.async {
            self.presentation = self.mapper.map(self.state)
        }
    }
}
