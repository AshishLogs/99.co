//
//  PoductDetailHighlightsTableViewCell.swift
//  99
//
//  Created by MegaMind on 22/10/21.
//

import UIKit
import Combine

class PoductDetailHighlightsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var rentingDetails: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var viewOnMap: UIButton!
    @IBOutlet weak var beds: UILabel!
    @IBOutlet weak var bathroom: UILabel!
    @IBOutlet weak var size: UILabel!
    
    var viewMap = PassthroughSubject<Bool, Never>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func viewMap(_ sender: Any) {
        viewMap.send(true)
    }
    func wrapView(model: ProductDetailsModel?) {
        self.price.text = model?.finalPrice
        self.productName.text = model?.projectName
        self.rentingDetails.text = model?.address?.title
        self.address.text = model?.address?.subtitle
        self.viewOnMap.setTitle("View on map", for: .normal)
        self.beds.text = "\(model?.attributes?.bedrooms ?? 0) Beds"
        self.bathroom.text = "\(model?.attributes?.bathrooms ?? 0) Baths"
        self.size.text = "\(model?.attributes?.areaSize ?? 0) sqft"
    }
    
}
