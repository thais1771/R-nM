//
//  String.swift
//
//
//  Created by Thais Rodríguez on 20/1/23.
//

import UIKit

public extension String {
    func contains(anyOf elements: [String]) -> Bool {
        return elements.filter { self.contains($0) }.isEmpty
    }

    var underLined: NSAttributedString {
        NSMutableAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
    static var magnifyingglass = "magnifyingglass"
    static var empty = ""
}
