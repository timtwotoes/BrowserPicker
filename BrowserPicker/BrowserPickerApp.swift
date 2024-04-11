//
//  BrowserPickerApp.swift
//  BrowserPicker
//
//  Created by Tim on 08/04/2024.
//

import SwiftUI

@main
struct BrowserPickerApp: App {
    var body: some Scene {
        Window("Browser Picker", id: "main") {
            ContentView().fixedSize(horizontal: false, vertical: true)
        }.windowResizability(.contentSize)
    }
}
