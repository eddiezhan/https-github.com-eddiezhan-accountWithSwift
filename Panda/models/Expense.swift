//
//  Expense.swift
//  Panda
//
//  Created by eddie.zhan on 2023/11/9.
//


import SwiftUI
import SwiftData

@Model
class Expense {
    var title: String
    var amount: Double
    var subTitle: String
    var date: Date
    var category: Category?
   
    init(title: String, amount: Double, subTitle: String, date: Date, category: Category? = nil) {
        self.title = title
        self.amount = amount
        self.subTitle = subTitle
        self.date = date
        self.category = category
    }
    @Transient
    var currentAmount: String{
        let formatter = NumberFormatter()
        formatter.numberStyle  = .currency
        return formatter.string(from: NSNumber(value: amount)) ?? ""
    }
}
