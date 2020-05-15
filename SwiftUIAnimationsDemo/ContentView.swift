//
//  ContentView.swift
//  SwiftUIAnimationsDemo
//
//  Created by Kaio Brito on 09/05/20.
//  Copyright © 2020 Kaio Brito. All rights reserved.
//

import SwiftUI

struct AppState {
    var isSignedIn = false
}

struct ContentView: View {
    @State var appState = AppState()

    var body: some View {
        ZStack {
            if (appState.isSignedIn) {
                DashboardView(appState: self.$appState)
                    .transition(
                        .asymmetric(insertion: .move(edge: .bottom), removal: .scale)
                )
            } else {
                SignInView(appState: self.$appState)
                    .transition(
                        .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
