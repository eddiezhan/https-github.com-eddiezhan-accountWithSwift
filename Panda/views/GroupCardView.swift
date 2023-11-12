//
//  GroupCardView.swift
//  Panda
//
//  Created by EddieZhan on 2023/11/12.
//

import SwiftUI

struct GroupCardView: View {
    @Bindable var expense: Expense
    var body: some View {
        HStack{
            VStack (alignment: .leading){
                Text(expense.title).bold()
                Text(expense.subTitle).font(.caption)
            }.lineLimit(1)
            Spacer(minLength: 5)
            Text(expense.currentAmount).font(.title3).bold()
            
        }
    }
}

