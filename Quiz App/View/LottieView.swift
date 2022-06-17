//
//  LottieView.swift
//  Quiz App
//
//  Created by Girish Parate on 17/06/22.
//

import SwiftUI

struct LottieView: View {
    
    var action: () -> Void?
    
    var body: some View {
        ZStack {
            LottieFileView(lottieFile: "passed")
            VStack {
                VStack {
                    Text("Passed !!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.accentColor)
                    Text("You made it.")
                        .padding(.top,1)
                        .foregroundColor(.gray)
                        .font(.title)
                }
                .padding(.top,46)
                Spacer()
                Button(action: {
                    
                }, label: {
                    Text("Finish")
                })
                .buttonStyle(RoundedRectangleButtonStyle())
                .padding()
            }
        }
    }
}

struct LottieView_Previews: PreviewProvider {
    static var previews: some View {
        LottieView(action:{
            print("Data")
        }
        )
    }
}
