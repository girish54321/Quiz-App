//
//  LoadingIndicator.swift
//  Quiz App
//
//  Created by Girish Parate on 13/06/22.
//

import SwiftUI
import ActivityIndicatorView

struct LoadingIndicator: View {
    @State private var loading = true
    var body: some View {
        ZStack {
            VStack {
            }
            .frame(width: 200, height: 180)
            .blur(radius: 80)
            .background(.gray.opacity(0.1))
            .opacity(0.7)
            .cornerRadius(18)
            .blur(radius: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(.gray.opacity(0.1), lineWidth: 4)
            )
            VStack {
                VStack (alignment: .center, spacing: 28){
                    ActivityIndicatorView(isVisible: $loading,
                                          type: .growingArc(.accentColor, lineWidth: 4)
                    )
                    .foregroundColor(.accentColor)
                    .frame(width: 50, height: 50)
                    Text("Loading..")
                        .font(.headline)
                }
            }
        }
    }
}

struct LoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicator()
    }
}
