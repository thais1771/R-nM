//
//  UICollectionViewLayout+.swift
//
//
//  Created by Thais Rodríguez on 21/1/23.
//

import UIKit

public extension UICollectionViewLayout {
    static func defaultLayout() -> UICollectionViewFlowLayout {
        let sectionInsets = UIEdgeInsets(top: 0,
                                         left: 10,
                                         bottom: 0,
                                         right: 10)
        
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        
        let itemsPerRow: CGFloat = 2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = UIScreen.main.bounds.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        flow.itemSize = CGSize(width: widthPerItem, height: widthPerItem + 50)
        flow.sectionInset = sectionInsets
        
        return flow
    }
}
