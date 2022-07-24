//
//  PRListingTableViewCell.swift
//  PRListing
//
//  Created by Tania Jasam on 24/07/22.
//

import UIKit
import Kingfisher

class PRListingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var prDescription: UILabel!
    @IBOutlet weak var creationDate: UILabel!
    @IBOutlet weak var closedDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userImageView.layer.cornerRadius = self.userImageView.frame.size.height/2
        self.userImageView.tintColor = .gray
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.userImageView.image = nil
    }

    func configure(prData: PRListingModel?) {
        guard let pullRequest: PRListingModel = prData else { return }
        
        self.title.text = pullRequest.title ?? ""
        self.prDescription.text = pullRequest.body ?? "Description NA"
        self.username.text = pullRequest.user?.login ?? ""
        self.creationDate.text = "Created at: \(Utility.convertDateFromString(stringDate: pullRequest.created_at ?? ""))"
        self.closedDate.text = "Closed at: \(Utility.convertDateFromString(stringDate: pullRequest.closed_at ?? ""))"
        self.userImageView.kf.setImage(with: URL(string: pullRequest.user?.avatar_url ?? ""), placeholder: UIImage(systemName: "person.fill"))
    }
}
