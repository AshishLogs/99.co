//
//  ProductDetailsDescriptionTableViewCell.swift
//  99
//
//  Created by MegaMind on 22/10/21.
//

import UIKit

class ProductDetailsDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var descrption: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func wrapView(desc: String?) {
        descrption.text = desc
    }
    
    
}
