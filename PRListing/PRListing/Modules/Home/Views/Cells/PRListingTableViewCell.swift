//
//  PRListingTableViewCell.swift
//  PRListing
//
//  Created by Tania Jasam on 24/07/22.
//

import UIKit

class PRListingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var prDescription: UILabel!
    @IBOutlet weak var creationDate: UILabel!
    @IBOutlet weak var closedDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(prData: PRListingModel) {
        self.title.text = prData.title ?? ""
        self.prDescription.text = prData.body ?? "Description NA"
        self.username.text = prData.user?.login ?? ""
    }
}
