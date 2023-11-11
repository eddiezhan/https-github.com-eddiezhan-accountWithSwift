//
//  ContentView.swift
//  Panda
//
//  Created by eddie.zhan on 2023/11/7.
//

import SwiftUI

struct ContentView: View {
    @State private var currentTab:String = "ExpensesView"
    var body: some View {
        
        TabView(selection: $currentTab){
            ExpensesView().tag("Expenses").tabItem {
                Image(systemName: "creditcard.fill")
                Text("Expenses")
            }
            CategorysView().tag("Categorys").tabItem {
                Image(systemName: "list.clipboard.fill")
                Text("Categorys")
            }
            
        }
        
    }
}





#Preview {
    ContentView()
}
