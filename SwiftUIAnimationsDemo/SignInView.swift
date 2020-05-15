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
    @State private var loaded = false

    var body: some View {
        ZStack {
            Color.heartRed.edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .zIndex(999)
                Spacer()
                
                VStack {
                    HStack(alignment: .center) {
                        Text("Log in").font(.headline).fontWeight(.semibold).foregroundColor(Color.heartRed)
                        Text("to you account")
                            .font(.subheadline)
                            .foregroundColor(Color.gray)
                    }
                    
                    VStack {
                        Spacer()
                        TextInput(label: "Username", icon: "envelope.fill")
                        VStack {
                            TextInput(label: "Password", icon: "lock.fill")
                            HStack {
                                Spacer()
                                Button (action: {}) {
                                    Text("Forgot your password?")
                                        .font(.subheadline)
                                        .foregroundColor(Color.heartRed)
                                        .multilineTextAlignment(.trailing)
                                }
                            }
                        }
                        Spacer()
                    }.padding(.vertical)
                    
                    
                    VStack {
                        SubmitButton(text: "Sign In", onSubmit: self.submit)
                        
                        Button(action:{}) {
                            HStack {
                                Text("Don't have an account?")
                                    .foregroundColor(Color.gray)
                                Text("Sign Up")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.heartRed)
                            }
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .edgesIgnoringSafeArea(.bottom)
                        .shadow(radius: 3)
                )
                .frame(maxHeight: 500)
                .background(
                    Image("busy")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity).offset(x: 0, y: -100)
                        .scaleEffect(self.loaded ? 1.1 : 1.0)
                        .animation(Animation.linear(duration: 15).repeatForever())
                        .onAppear {
                            self.loaded = true
                    },
                    alignment: .top)
            }
            .blur(radius: isSubmitting ? 9 : 0.0)
            
            VStack {
                Spacer()
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding()
                    .foregroundColor(Color.darkGray)
                    .background(
                        Circle()
                            .stroke(lineWidth: 3)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.heartRed, Color.secondaryYellow ,Color.darkGray]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .rotationEffect(Angle(degrees: isSubmitting ? 360 + 90 : 90))
                            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                )
                Text("Submitting")
                Spacer()
            }
            .opacity(isSubmitting ? 1.0 : 0.0)
        }.animation(.easeIn)
    }

    func submit() {
        self.isSubmitting = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isSubmitting = false
            self.appState.isSignedIn = true
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignInView(appState: Binding<AppState>.constant(AppState()))
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                .previewDisplayName("iPhone SE")
            SignInView(appState: Binding<AppState>.constant(AppState()))
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
                .previewDisplayName("iPhone 11 pro")
        }
    }
}

struct TextInput: View {
    var label: String
    var icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5.0) {
            HStack {
                Text(label)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.horizontal)
            HStack {
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(Color.darkGray)
                        .scaledToFit()
                    Spacer()
                    Rectangle()
                        .fill(Color.darkGray)
                        .frame(width: 1)
                        .padding(.vertical)
                }
                .frame(width: 24)
                
                TextField(label, text: Binding<String>.constant(""))
                
            }
            .frame(height: 52)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(radius: 1)
            )
        }.frame(maxWidth: .infinity)
    }
}

struct SubmitButton: View {
    var text: String
    var onSubmit: () -> Void
    @State var isPressing = false

    var body: some View {
        HStack {
            Text(text)
        }
        .foregroundColor(Color.white)
        .frame(height: 64)
        .frame(maxWidth: .infinity)
        .background(Color.heartRed)
        .cornerRadius(8)
        .padding(.vertical)
        .shadow(radius: 2)
        .scaleEffect(isPressing ? 0.9 : 1.0)
        .onTapGesture(perform: self.onSubmit)
        .onLongPressGesture(minimumDuration: 1, maximumDistance: 32, pressing: {
            self.isPressing = $0
        }, perform: {
            self.isPressing.toggle()
        })
    }
}
