//
//  ContentView.swift
//  Vision Clock
//
//  Created by Paul Sri on 2/10/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @State private var currentTime = ""
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    //func getCurrentTime() -> String {
      //  let formatter = DateFormatter()
      //  formatter.timeStyle = .short
      //  let dateString = formatter.string(from: Date())
      //  return dateString
    //}
    func updateCurrentTime() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            self.currentTime = formatter.string(from: Date())
            
        }
    }
    var body: some View {
        VStack {
            //Model3D(named: "Scene", bundle: //realityKitContentBundle)
                //.padding(.bottom, 50)
            //let currentTime = getCurrentTime()
            Text(currentTime)
                .font(.system(size: 80, design: .rounded))
                .fontWeight(.light)
                .monospacedDigit()
                .onAppear(perform: updateCurrentTime)
            //Text("Hello, world!")

            //Toggle("Show Immersive Space", isOn: //$showImmersiveSpace)
                //.toggleStyle(.button)
                //.padding(.top, 50)
        }
        .padding()
        .onChange(of: showImmersiveSpace) { _, newValue in
            Task {
                if newValue {
                    switch await openImmersiveSpace(id: "ImmersiveSpace") {
                    case .opened:
                        immersiveSpaceIsShown = true
                    case .error, .userCancelled:
                        fallthrough
                    @unknown default:
                        immersiveSpaceIsShown = false
                        showImmersiveSpace = false
                    }
                } else if immersiveSpaceIsShown {
                    await dismissImmersiveSpace()
                    immersiveSpaceIsShown = false
                }
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
