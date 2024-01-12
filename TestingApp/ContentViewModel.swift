//
//  ContentViewModel.swift
//  TestingApp
//
//  Created by Maks Winters on 12.01.2024.
//

import Foundation
import UIKit
import SwiftUI

@Observable
class ContentViewModel: ObservableObject {
    
    var rows: [[Tag]] = []
    var tags: [Tag] = [
        Tag(name: "XCode", color: .blue),
        Tag(name: "IOS", color: .green),
        Tag(name: "IOS App Development", color: .orange),
        Tag(name: "Swift", color: .red),
        Tag(name: "SwiftUI", color: .purple)
    ]
    var tagText = ""
    
    var selectedColor = Color.red
    var isShowingSelectior = false
    
    func getTags(){
        var rows: [[Tag]] = []
        var currentRow: [Tag] = []
        
        var totalWidth: CGFloat = 0
        
        let screenWidth = UIScreen.screenWidth - 10
        let tagSpaceing: CGFloat = 14 /*Leading Padding*/ + 15 /*Trailing Padding*/ + 6 + 6 /*Leading & Trailing 6, 6 Spacing*/
        
        if !tags.isEmpty{
            
            for index in 0..<tags.count{
                self.tags[index].size = tags[index].name.getSize()
            }
            
            tags.forEach{ tag in
                
                totalWidth += (tag.size + tagSpaceing)
                
                if totalWidth > screenWidth{
                    totalWidth = (tag.size + tagSpaceing)
                    rows.append(currentRow)
                    currentRow.removeAll()
                    currentRow.append(tag)
                }else{
                    currentRow.append(tag)
                }
            }
            
            if !currentRow.isEmpty{
                rows.append(currentRow)
                currentRow.removeAll()
            }
            
            self.rows = rows
        }else{
            self.rows = []
        }
        
    }
    
    func addTag(){
        guard !tagText.isEmpty else { return } 
        tags.append(Tag(name: tagText, color: selectedColor))
        tagText = ""
        getTags()
    }

    func removeTag(by id: String){
        tags = tags.filter{ $0.id != id }
        getTags()
    }
    
    init(){
        getTags()
    }
    
}
