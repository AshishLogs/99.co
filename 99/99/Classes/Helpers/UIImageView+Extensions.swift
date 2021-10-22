//
//  UIImageView+Extensions.swift
//  99
//
//  Created by MegaMind on 23/10/21.
//

import SDWebImage
import UIKit

extension UIImageView {
    
    func setImage(_ url: URL?) {
        self.sd_setImage(with: url, completed: nil)
    }
    
}
