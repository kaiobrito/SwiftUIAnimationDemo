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
    @ObservedObject var viewModel: DashboardViewModel = DashboardViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if (self.viewModel.humans.isEmpty) {
                    LoadingGridView()
                        .padding()
                }

                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(self.viewModel.humans.chunked(into: 3), id: \.self) { section in
                            HStack {
                                ForEach(section) {
                                    HumanView(human: $0)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .onAppear {
                self.viewModel.loadTeam()
            }
            .navigationBarTitle("Team")
            .navigationBarItems(trailing: Button(action: { self.appState.isSignedIn.toggle() }) {
                Text("Logout")
            })
        }
    }
}

extension DashboardView {
    
    class DashboardViewModel: ObservableObject {
        @Published var humans: [Human] = Bundle.main.decode([Human].self, from: "team.json")

        func loadTeam() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.humans = Bundle.main.decode([Human].self, from: "team.json")
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(appState: Binding<AppState>.constant(AppState()))
    }
}
