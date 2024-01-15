//
//  Tag.swift
//  TestingApp
//
//  Created by Maks Winters on 12.01.2024.
//

import Foundation
import SwiftUI

struct Tag: Identifiable, Hashable{
    var id = UUID().uuidString
    var name: String
    var size: CGFloat = 0
    let color: Color
}
