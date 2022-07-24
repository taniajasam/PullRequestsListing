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
    @IBOutlet weak var prListingTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialiseTableView()
        self.bindViewModel()
        self.viewModel.fetchPullRequests()
    }
    
    func initialiseTableView() {
        prListingTableView.register(UINib.init(nibName: "PRListingTableViewCell", bundle: nil), forCellReuseIdentifier: "PRListingTableViewCell")
        prListingTableView.dataSource = self
        prListingTableView.delegate = self
    }
    
    func bindViewModel() {
        viewModel.$listingData
            .receive(on: RunLoop.main)
            .sink { [weak self] listingData in
                self?.prListingTableView.reloadData()
            }
            .store(in: &subscriptions)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.listingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: PRListingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PRListingTableViewCell", for: indexPath) as? PRListingTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(prData: viewModel.listingData[indexPath.row])
        return cell
    }
}


