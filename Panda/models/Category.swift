//
//  Category.swift
//  Panda
//
//  Created by eddie.zhan on 2023/11/9.
//

import SwiftData
import SwiftUI

@Model
class Category {
    var categoryName: String
    
    @Relationship(deleteRule: .cascade ,inverse: \Expense.category)
    var expenses: [Expense]?
    
    init(categoryName: String) {
        self.categoryName = categoryName
    }
    
}
