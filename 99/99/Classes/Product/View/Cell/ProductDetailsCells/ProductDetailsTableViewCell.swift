//
//  ProductDetailsTableViewCell.swift
//  99
//
//  Created by MegaMind on 22/10/21.
//

import UIKit

class ProductDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var stackview: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func wrapView(model: ProductDetailsModel?) {
        model?.propertyDetails?.forEach({ (details) in
            let sv = UIStackView(frame: .init(x: 0, y: 0, width: self.stackview.frame.width, height: 22.0))
            sv.axis = .horizontal
            sv.alignment = .fill
            sv.distribution = .fill

            let title = UILabel(frame: .init(x: 0, y: 0, width: 150.0, height: 22))
            title.font = UIFont(name: "AvenirNext-Medium", size: 16.0)
            title.textColor = UIColor(red: 26.0/255.0, green: 34.0/255.0, blue: 88.0/255.0, alpha: 1.0)
            title.text = details.label
            title.translatesAutoresizingMaskIntoConstraints = false
            let widthConstraint = NSLayoutConstraint(item: title, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 150.0)
            title.addConstraints([widthConstraint])

            
            sv.addArrangedSubview(title)
            
            let textValue = UILabel(frame: .init(x: 150.0, y: 0, width: 80.0, height: 22))
            textValue.font = UIFont(name: "AvenirNext-Regular", size: 16.0)
            textValue.textColor = UIColor(red: 26.0/255.0, green: 34.0/255.0, blue: 88.0/255.0, alpha: 1.0)
            textValue.text = details.text
            textValue.autoresizingMask = .flexibleWidth
            
            sv.addArrangedSubview(textValue)
            sv.layoutIfNeeded()
            self.stackview.addArrangedSubview(sv)
            self.stackview.layoutIfNeeded()
        })
        
        self.layoutIfNeeded()
    }
    
    
}
