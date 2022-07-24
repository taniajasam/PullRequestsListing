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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
        prListingTableView.rowHeight = UITableView.automaticDimension
    }
    
    func bindViewModel() {
        viewModel.$listingData
            .receive(on: RunLoop.main)
            .sink { [weak self] listingData in
                if listingData != nil {
                    self?.prListingTableView.reloadData()
                    self?.activityIndicator.stopAnimating()
                }
            }
            .store(in: &subscriptions)
        
        viewModel.$error
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                if error != nil {
                    self?.showAlertForError(error: error)
                    self?.activityIndicator.stopAnimating()
                }
            }
            .store(in: &subscriptions)
    }
    
    func showAlertForError(error: Error?) {
        let alertController: UIAlertController = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alertController, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: PRListingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PRListingTableViewCell", for: indexPath) as? PRListingTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(prData: viewModel.listingData?[indexPath.row])
        return cell
    }
}


