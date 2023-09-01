//
//  UIImage+Extension.swift
//  Posts_TestAssignment
//
//  Created by Maxym Bilyk on 01.09.2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(with stringURL: String) {
        guard let imageURL = URL(string: stringURL) else { return }
        setImage(with: imageURL)
    }
    
    func setImage(with url: URL) {
        self.kf.setImage(
            with: .network(url),
            placeholder: nil,
            options: [
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.fade(0.25))
            ]
        )
    }
}
