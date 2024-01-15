//
//  ExtensionsForTags.swift
//  TestingApp
//
//  Created by Maks Winters on 12.01.2024.
//

import Foundation
import UIKit

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.width
}

extension String{
    func getSize() -> CGFloat{
        let font = UIFont.systemFont(ofSize: 16)
        let attributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: attributes)
        return size.width
    }
}
