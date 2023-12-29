//
//  VisionOSFullSpaceRealityViewApp.swift
//  VisionOSFullSpaceRealityView
//
//  Created by Sadao Tokuyama on 12/28/23.
//

import SwiftUI

@main
struct VisionOSFullSpaceRealityViewApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.windowStyle(.volumetric)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.mixed), in: .mixed)
    }
}
