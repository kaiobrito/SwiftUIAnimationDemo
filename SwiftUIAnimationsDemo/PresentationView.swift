//
//  PresentationView.swift
//  SwiftUIAnimationsDemo
//
//  Created by Kaio Brito on 12/06/20.
//  Copyright © 2020 Kaio Brito. All rights reserved.
//

import SwiftUI

struct PresentationView: View {
    @State var showModal = false
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.6).edgesIgnoringSafeArea(.all)
            VStack {
                Text("Hi!")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Spacer()
                Button(action: { self.showModal.toggle() }) {
                    Text("Sign In")
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .blur(radius: self.showModal ? 10 : 0)
            .scaleEffect(self.showModal ? 0.9 : 1.0)
            .animation(.spring())
            
            VStack {
                Circle()
                    .stroke(
                        LinearGradient(gradient: Gradient(colors: [Color.black,Color.yellow ,Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing),
                        lineWidth: 2)
                    .frame(width: 60, height: 60)
                    .rotation3DEffect(Angle(degrees: self.showModal ? 360 : 0), axis: (x: 0, y: 1, z: 1))
                    .animation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false))
                
                Button(action: { self.showModal.toggle() }) {
                    Text("Cancel")
                }
                .padding()
            }
            .padding()
            .opacity(self.showModal ? 1 : 0)
            .animation(.spring())
        }
    }
}


struct PresentationView_Previews: PreviewProvider {
    static var previews: some View {
        PresentationView()
    }
}
