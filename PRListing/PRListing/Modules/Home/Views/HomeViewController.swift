//
//  HomeViewController.swift
//  PRListing
//
//  Created by Tania Jasam on 24/07/22.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    private var viewModel: HomeViewModel = HomeViewModel(networkManager: NetworkManager.sharedInstance)
    var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
        self.viewModel.fetchPullRequests()
    }
    
    func bindViewModel() {
        viewModel.$listingData
            .receive(on: RunLoop.main)
            .sink { listingData in
                print(listingData.count)
            }
            .store(in: &subscriptions)
    }

}


