//
//  SignInView.swift
//  SwiftUIAnimationsDemo
//
//  Created by Kaio Brito on 14/05/20.
//  Copyright © 2020 Kaio Brito. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @Binding var appState: AppState
    @State var isSubmitting = false

    var body: some View {
        ZStack {
            ZStack {
                VStack {
                    Text("Welcome")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    Spacer()
                    HStack {
                        Spacer()
                        Text("Continue")
                        Image(systemName: "arrow.right")
                    }
                    .padding(.horizontal)
                    .foregroundColor(Color.white)
                    .frame(height: 64)
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .onTapGesture(perform: self.submit)
                }.background(Color.white)
            }
            .blur(radius: isSubmitting ? 9 : 0.0)
                VStack {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
                        .background(
                            Circle()
                                .stroke(lineWidth: 3)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.black ,Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .rotationEffect(Angle(degrees: isSubmitting ? 360 + 90 : 90))
                                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                        )
                    Text("Submitting")
                }
            .opacity(isSubmitting ? 1.0 : 0.0)
        }.animation(.easeIn)
    }

    func submit() {
        self.isSubmitting = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isSubmitting = false
            self.appState.isSignedIn = true
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(appState: Binding<AppState>.constant(AppState()))
    }
}
