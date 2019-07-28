//
//  MyCurrencyTableViewCell.swift
//  Make It Rain
//
//  Created by Timothy on 4/29/19.
//  Copyright © 2019 Timothy. All rights reserved.
//

import UIKit

class MyCurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sampleBanknoteImageView: UIImageView!
    @IBOutlet weak var containerBanknoteView: UIView!
    @IBOutlet weak var overlayView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.overlayView.layer.cornerRadius = 10
        containerBanknoteView.layer.cornerRadius = 10
        self.backgroundColor = .clear
        self.sampleBanknoteImageView.layer.cornerRadius = 10
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
