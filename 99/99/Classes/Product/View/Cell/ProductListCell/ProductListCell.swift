//
//  ProductListCell.swift
//  99
//
//  Created by MegaMind on 21/10/21.
//

import UIKit

class ProductListCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var address1: UILabel!
    @IBOutlet weak var address2: UILabel!
    @IBOutlet weak var attributes: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.cardViewShadow()
        productImage.layer.masksToBounds = true
        productImage.layer.cornerRadius = 4.0
    }
    
    func wrapView(model: ProductListElement) {
        self.productName.text = model.projectName
        self.address1.text = model.fullAddress
        self.address2.text = model.projectDetails
        self.attributes.text = model.productAttributes
        self.price.text = model.finalPrice
        self.productImage.setImage(URL(string: model.photo))
    }
    
}
