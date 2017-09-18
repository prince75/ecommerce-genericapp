//
//  HomePageViewModel.swift
//  ecommerce-generic-app
//
//  Created by Kuliza-282 on 11/09/17.
//  Copyright © 2017 Ansu. All rights reserved.
//

import Foundation

protocol HomePageViewModelling {
    
    // MARK: INPUT
    var tableItemTypes: [CellRepresentable.Type] { get }
    var tableViewDataSource: [CellRepresentable] { get }
}

class HomePageViewModel: HomePageViewModelling {
    
    
    //Mark Input
    private(set) var isLoading : Dynamic<Bool> = Dynamic(false)
    
    
    var didUpdate: (() -> Void)?
    var didError: ((Error) -> Void)?
   // var didSelectIndex: ((SearchItem) -> Void)?
    
    var content :[Content] = [Content]()
   
    
    //MARK: - Private
    private let api: CommonServiceProtocol
    
    //MARK: - Properties
    var tableViewDataSource: [CellRepresentable] = []
    var tableItemTypes: [CellRepresentable.Type] = [ListCellViewModel.self, CollectionTableCellViewModel.self]
    
    //MARK: - Lifeycle
    init(api: CommonServiceProtocol) {
        self.api = api
    }
    
    func callHomePageAPI(){
        self.isLoading.value = true
        self.api.getHomePageData() {[weak self] (result) in
            self?.isLoading.value = false
            switch result {
                case .Success(let data):
                    self?.content = (data?.content!)!
                    self?.didUpdate?()
                case .Error(let error):
                    print(error.description)
            }
            
        }
        
        
    }

}
