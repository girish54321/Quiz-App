//
//  WidgetView.swift
//  Quiz App
//
//  Created by Girish Parate on 11/09/22.
//

import SwiftUI

struct WidgetView: View {
    var score: String
    var body: some View {
        VStack {
            HStack {
                Text("Highest Scorer")
                    .font(.body)
                Spacer()
                Text(score)
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.indigo)
            }
            .padding()
            Spacer()
            HStack {
                Image("select").resizable()
                    .aspectRatio(contentMode: .fit)
                .frame(width: 45, height: 45)
                Spacer()
                Text("Quiz App")
                    .font(.footnote)
                    .foregroundColor(Color.indigo)
                    .fontWeight(.semibold)
            }
            .padding()
        }
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView(score: "22")
    }
}
