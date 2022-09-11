//
//  WidgetView.swift
//  Quiz App
//
//  Created by Girish Parate on 11/09/22.
//

import SwiftUI

struct WidgetView: View {
    var body: some View {
        VStack {
            HStack {
                Text("You Highest Scorer")
                    .font(.headline)
                    .padding()
                Spacer()
                Text("23")
                    .font(.headline)
                    .foregroundColor(Color.indigo)
                    .padding()
            }
            Spacer()
            HStack {
                Image("select").resizable()
                    .aspectRatio(contentMode: .fit)
                .frame(width: 70, height: 70)
                .padding()
                Spacer()
            }
        }
        .background(.gray)
     
//            .clipShape(Circle())
//            .overlay(Circle().stroke(Color.purple,lineWidth: 5))
//            .shadow(radius: 15)
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView()
    }
}
