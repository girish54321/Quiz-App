//
//  UIHelper.swift
//  Quiz App
//
//  Created by Girish Parate on 11/06/22.
//

import SwiftUI
import HTMLEntities

struct RoundedRectangleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label.foregroundColor(.white)
            Spacer()
        }
        .allowsHitTesting(false)
        .padding()
        .background(Color.accentColor.cornerRadius(8))
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}


struct QuustionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label.foregroundColor(.white)
            Spacer()
        }
        .allowsHitTesting(false)
        .padding()
        .background(Color.accentColor.cornerRadius(8))
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct WorngQuustionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label.foregroundColor(.white)
            Spacer()
        }
        .allowsHitTesting(false)
        .padding()
        .background(Color.red.cornerRadius(8))
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct RightQuustionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label.foregroundColor(.white)
            Spacer()
        }
        .allowsHitTesting(false)
        .padding()
        .background(Color.green.cornerRadius(8))
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

extension Image {
    func imageModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
}

//extension Text {
//    func textModifier() -> some View {
//        self
//            .resizable()
//            .scaledToFit()
//    }
//}


struct UIHelper {
    
    func formateHelptext(text: String) -> String {
        return text.htmlUnescape()
    }
    
}
