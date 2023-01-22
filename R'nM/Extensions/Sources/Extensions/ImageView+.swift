//
//  UIImageView+.swift
//  
//
//  Created by Thais Rodríguez on 21/1/23.
//

import UIKit
import NukeExtensions

public extension UIImageView {
    func nukeLoad(url: URL) {
        NukeExtensions.loadImage(with: url, into: self)
    }
}
