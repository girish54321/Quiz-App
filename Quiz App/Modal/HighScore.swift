//
//  HighScore.swift
//  Quiz App
//
//  Created by Girish Parate on 10/09/22.
//

import Foundation

struct HighScore: Identifiable, Codable {
    let score : String
    let scoreNumber : Int
    var id : UUID = UUID()
}

