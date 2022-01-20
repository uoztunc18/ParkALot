//
//  ReviewTableCell.swift
//  ParkALot
//
//  Created by Lab on 20.01.2022.
//

import UIKit

class ReviewTableCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var reviewBox: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
