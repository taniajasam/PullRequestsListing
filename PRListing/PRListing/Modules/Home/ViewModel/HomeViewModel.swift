//
//  HomeViewModel.swift
//  PRListing
//
//  Created by Tania Jasam on 24/07/22.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    lazy var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    var networkManager: NetworkRequestable?
    @Published var listingData: [PRListingModel]?
    @Published var error: Error?
    
    init(networkManager: NetworkRequestable) {
        self.networkManager = networkManager
    }
    
    func fetchPullRequests() {
        networkManager?.dataTask(with: HomeAPIConfiguration(), type: PRListingModel.self)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.error = error
                    
                default:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.listingData = response
            })
            .store(in: &subscriptions)
    }
    
    func getNumberOfItems() -> Int {
        self.listingData?.count ?? 0
    }
}
