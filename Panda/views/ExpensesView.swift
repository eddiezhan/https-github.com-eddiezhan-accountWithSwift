//
//  ExpenseView.swift
//  Panda
//
//  Created by eddie.zhan on 2023/11/9.
//

import SwiftUI
import SwiftData

struct ExpensesView: View {
    
    //创建一个私有变量（花费数组），来查询全部的花费，并且按照日期倒序排序
    @Query(sort: [SortDescriptor(\Expense.date, order: .reverse)], animation: .snappy) private var allExpenses: [Expense]
    
    //创建一个空的数组，类型是 分组花费
    @State private var groupedExpenses: [GroupedExpenses] = []
    @State private var addExpense: Bool = false
    var body: some View {
        NavigationStack{
            List {
                
            }.navigationTitle("Expenses")//创建一个名为Expense 的导航视图
            // 当所有花费为空，或者 组花费为空的时候， 显示一个 NO expense的图标
                .overlay{
                    if allExpenses.isEmpty || groupedExpenses.isEmpty {
                        ContentUnavailableView{
                            Label("NO Expenses",systemImage: "tray.fill")
                        }
                    }
                }
            // 顶部右上角 添加一个 加号图标
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing){
                        Button{
                            addExpense.toggle()
                        }label: {
                            Image(systemName: "plus.circle.fill").font(.title3)
                        }
                    }
                }
        }
        //使用了.onChange修饰器，监测allExpenses数组的变化，在第一次加载时，调用createGroupedExpenses方法将费用按日期进行分组。
        .onChange(of: allExpenses, initial: true){ oldValue , newValue in
            if groupedExpenses.isEmpty {
                createGroupedExpenses(newValue)
            }
        }
        .sheet(isPresented: $addExpense, content: {
            AddExpenseView()
        })
    }
    // creating group expense （Grouping by date）
    func createGroupedExpenses(_ expenses: [Expense]){
        // 创建一个线程用来将 花费 分组并返回
        Task.detached(priority: .high){
            // 将花费先分组，按照日期 分组
            let groupedDict = Dictionary(grouping: expenses){ expense in
                // 会传递 日月年 组件给 日期
                let dateComponments = Calendar.current.dateComponents([.day, .month, .year], from: expense.date)
                return dateComponments
            }            
            //sorting dictionary in descening order
            let sortedDict = groupedDict.sorted{
                let calendar = Calendar.current
                // 排序 根据每两个中日期 先后 来降序排列
                let date1 = calendar.date(from: $0.key) ?? .init()
                let date2 = calendar.date(from: $1.key) ?? .init()
                return calendar.compare(date1, to: date2, toGranularity: .day) == .orderedDescending
            }
            // adding to the grouped expenses array
            // ui must be updated on main thread
            await MainActor.run {
                groupedExpenses = sortedDict.compactMap({ dict in
                    let date = Calendar.current.date(from: dict.key) ?? .init()
                    return .init(date: date, expenses: dict.value)
                })
            }
        }
    }
}




#Preview {
    ExpensesView()
}
