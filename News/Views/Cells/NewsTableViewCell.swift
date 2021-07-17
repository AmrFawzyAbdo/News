//
//  NewsTableViewCell.swift
//  News
//
//  Created by RKAnjel on 7/15/21.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var sourceLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.newsImage.layer.cornerRadius = 10
        self.newsImage.clipsToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
