//
//  ListItemCell.swift
//  Animate Table
//
//  Created by Dinh Le on 13/03/16.
//  Copyright © 2016 Dinh Le. All rights reserved.
//

import UIKit

class ListItemCell: UITableViewCell {
    static let HEIGHT_LIST_CELL = CGFloat(96)
    static let HEIGHT_LIST_CELL_COLAPSE = CGFloat(44)

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var iconBranchImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    let iconOriginSize:CGSize = CGSizeMake(79, 79)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func colapseExpanseCell(isColapse : Bool) {
        if isColapse == true {
            self.iconBranchImageView.frame.size = CGSizeZero
            self.iconBranchImageView.hidden = true
            self.descriptionLabel.hidden = true
        } else {
            self.iconBranchImageView.frame.size = iconOriginSize
            self.iconBranchImageView.hidden = false
            self.descriptionLabel.hidden = false
        }
        self.setNeedsLayout()
    }
}
