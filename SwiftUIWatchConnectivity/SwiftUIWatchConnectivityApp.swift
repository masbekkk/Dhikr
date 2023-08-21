//
//  SwiftUIWatchConnectivityApp.swift
//  SwiftUIWatchConnectivity
//
//  Created by Chris Gaafary on 4/19/21.
//

import SwiftUI

@main
struct SwiftUIWatchConnectivityApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
            CountView(detailDhikr: .constant(DetailDhikr(id: 1, name: "Any Dhikr", amount: 10)))
//            CombineView(detailDhikr: .constant(DetailDhikr(id: 1, name: "Any Dhikr", amount: 33)))
        }
    }
}
