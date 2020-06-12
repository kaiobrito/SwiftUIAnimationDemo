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
    @State var itemsPerRow = 3
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(self.viewModel.humans.chunked(into: itemsPerRow), id: \.self) { section in
                        HStack {
                            ForEach(section) {
                                HumanView(human: $0)
                            }
                            self.createEmptyRows(self.itemsPerRow - section.count)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
            }
            .background(
                ZStack {
                    if (self.viewModel.humans.isEmpty) {
                        LoadingGridView()
                            .padding()
                    }
                }
            )
            .onAppear {
                self.viewModel.loadTeam()
            }
            .navigationBarTitle("Team")
            .navigationBarItems(trailing: Button(action: { self.appState.isSignedIn.toggle() }) {
                Text("Logout")
            })
        }
    }
    
    private func createEmptyRows(_ total: Int) -> some View {
        ForEach(0 ..< total, id: \.self) { _ in
            Circle()
                .fill(Color.clear)
        }
    }
}

extension DashboardView {
    
    class DashboardViewModel: ObservableObject {
        @Published var humans: [Human] = []

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
