//
//  Vision_ClockApp.swift
//  Vision Clock
//
//  Created by Paul Sri on 2/10/24.
//

import SwiftUI

@main
struct Vision_ClockApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
