//
//  AddExpenseView.swift
//  Panda
//
//

import SwiftUI
import Foundation
import SwiftData

struct AddExpenseView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var title: String = ""
    @State private var subTitle: String = ""
    @State private var date: Date = .init()
    @State private var amount: CGFloat = 0
    @State private var category: Category?
    //查询全部的 类别
    @Query(animation: .snappy) private var allCategories: [Category]
    
    //添加花费的 视图
    var body: some View {
        NavigationStack{
            List{
                Section("Title"){
                    TextField("Magic Keyboard", text: $title)
                }
                Section("Description"){
                    TextField("Buy something", text: $subTitle)
                }
                Section("Amount Spent"){
                    HStack(spacing: 4){
                        Text("$").fontWeight(.semibold)
                        TextField("0.0", value: $amount,formatter: formatter)
                            .keyboardType(.numberPad)
                    }
                }
                Section("Date"){
                    DatePicker("", selection: $date , displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                }
                // category picker
                if !allCategories.isEmpty {
                    HStack{
                        Text("Category")
                        
                        Spacer()
                        
                        Picker("", selection: $category){
                            ForEach(allCategories){
                                Text($0.categoryName).tag($0)
                            }
                        }.pickerStyle(.menu)
                            .labelsHidden()
                    }
                }
            }.navigationTitle("Add Expense")
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing){
                        Button("Cancel"){
                            dismiss()
                        }.tint(.red)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing){
                        Button("ADD",action: addExpense).disabled(isAddButtonDisabled)
                    }
                }
        }
    }
    
    //disables add button until title amount date is not null
    
    var isAddButtonDisabled: Bool {
        return title.isEmpty || amount  == .zero
    }
    
     
    // adding expense to the swift data
    func addExpense() {
        let expenses = Expense(title: title, amount: amount, subTitle: subTitle, date: date, category: category)
        context.insert(expenses)
        // closing the view, Once the Data has been saved successful
        dismiss()
    }
    var formatter:NumberFormatter{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
}

#Preview {
    AddExpenseView()
}
