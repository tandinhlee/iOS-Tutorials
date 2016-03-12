//
//  ListItemCell.swift
//  Animate Table
//
//  Created by Dinh Le on 13/03/16.
//  Copyright © 2016 Dinh Le. All rights reserved.
//

import UIKit

class ListItemCell: UITableViewCell {

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var peopleSubcribeLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    let iconOriginSize:CGSize = CGSizeMake(79, 79)
    var isColapse = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func colapseCell() {
        isColapse = !isColapse
        if isColapse {
            self.iconImageView.frame.size = CGSizeZero
            self.iconImageView.hidden = true
            self.peopleSubcribeLabel.hidden = true
        } else {
            self.iconImageView.frame.size = iconOriginSize
            self.iconImageView.hidden = false
            self.peopleSubcribeLabel.hidden = false
        }
        self.setNeedsLayout()
    }
}
