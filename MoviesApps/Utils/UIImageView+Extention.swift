//
//  UIImageViewExtention.swift
//  MoviesApps
//
//  Created by Rifqi Alfaizi on 19/09/22.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(from url: String, contentMode mode: ContentMode = .scaleAspectFit) {
        let url = URL(string: url)
        kf.setImage(with: url)
    }
    
}
