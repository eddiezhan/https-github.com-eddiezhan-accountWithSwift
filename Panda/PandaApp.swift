//
//  PandaApp.swift
//  Panda
//
// 
//

import SwiftUI

@main
struct PandaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // 设置容器
        .modelContainer(for: [Expense.self, Category.self])
    }
}
