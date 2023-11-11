//
//  GroupedExpenses.swift
//  Panda
//
//  Created by eddie.zhan on 2023/11/9.
//

import SwiftUI

struct GroupedExpenses {
    var id: UUID = .init()
    var date: Date
    var expenses: [Expense]
    
    var groupTitle: String{
        let current = Calendar.current
        if current.isDateInToday(date){
            return "Today"
        }else if current.isDateInYesterday(date){
            return "Yestoday"
        }else {
            return date.formatted(date: .abbreviated, time: .omitted)
        }
    }
}
