//
//  TableViewCell.swift
//  EmailListV5
//
//  Created by user on 4/2/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        label.font = UIFont.boldSystemFont(ofSize: 12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
