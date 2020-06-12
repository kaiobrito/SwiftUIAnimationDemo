//
//  LoadingGridView.swift
//  SwiftUIAnimationsDemo
//
//  Created by Kaio Brito on 12/06/20.
//  Copyright © 2020 Kaio Brito. All rights reserved.
//

import SwiftUI

struct LoadingGridView: View {
    @State var isAnimating = false
    var body: some View {
        VStack {
            ForEach(0 ..< 6) { item in
                HStack {
                    ForEach(0 ..< 3) { item in
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 100)
                    }
                }
            }
        }
        .opacity(self.isAnimating ? 1.0 : 0)
        .animation(Animation.linear(duration: 0.5).repeatForever(autoreverses: true))
        .onAppear {
            self.isAnimating = true
        }
    }
}

struct LoadingGridView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingGridView()
    }
}
