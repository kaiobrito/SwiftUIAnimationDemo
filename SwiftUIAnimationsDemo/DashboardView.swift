//
//  DashboardView.swift
//  SwiftUIAnimationsDemo
//
//  Created by Kaio Brito on 14/05/20.
//  Copyright © 2020 Kaio Brito. All rights reserved.
//

import SwiftUI

struct DashboardView: View {
    @Binding var appState: AppState
    
    var body: some View {
        Button(action: { self.appState.isSignedIn.toggle() }) {
            Text("Logout")
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(appState: Binding<AppState>.constant(AppState()))
    }
}
