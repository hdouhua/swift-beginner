//
//  SpecialTableViewCell.swift
//  HelloTableView
//
//  Created by Yilin on 2019/7/28.
//  Copyright © 2019 Yilin. All rights reserved.
//

import UIKit

class SpecialTableViewCell: UITableViewCell {
    @IBOutlet var specialImageView: UIImageView!
    @IBOutlet var specialLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
