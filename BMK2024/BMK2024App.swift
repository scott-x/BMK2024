//
//  BMK2024App.swift
//  BMK2024
//
//  Created by Scott on 2024/11/9.
//

import SwiftUI

@main
struct BMK2024App: App {
    init(){
        initDB()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
