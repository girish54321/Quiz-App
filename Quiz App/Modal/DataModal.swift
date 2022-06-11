//
//  DataModal.swift
//  Quiz App
//
//  Created by Girish Parate on 10/06/22.
//

import Foundation

struct Category: Identifiable, Hashable{
    var id = UUID()
    var title: String
    var value: Int
}

struct Difficulty: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var value: String
}

struct QuestionyType: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var value: String
}

let QuestionyTypeList: [QuestionyType] = [
    QuestionyType(title: "Any Type", value: "Any Type"),
    QuestionyType(title: "Multiple Choice", value: "Multiple Choice"),
    QuestionyType(title: "True / False", value: "True / False")
]

let DifficultyList: [Difficulty] = [
    Difficulty(title: "Easy", value: "Easy"),
    Difficulty(title: "Medium", value: "Medium"),
    Difficulty(title: "Hard", value: "Hard")
]

let CategoryList: [Category] = [
    Category (
        title: "General Knowledge",
        value: 9
    ),
    Category (
        title: "Entertainment: Books",
        value: 10
    ),
    Category (
        title: "Entertainment: Film",
        value: 11
    ),
    Category (
        title: "Entertainment: Music",
        value: 12
    ),
    Category (
        title: "Entertainment: Musicals &amp; Theatres",
        value: 13
    ),
    Category (
        title: "Entertainment: Television",
        value: 14
    ),
    Category (
        title: "Entertainment: Video Games",
        value: 15
    ),
    Category (
        title: "Entertainment: Board Games",
        value: 16
    ),
    Category (
        title: "Science &amp; Nature",
        value: 17
    ),
    Category (
        title: "Science: Computers",
        value: 18
    ),
    Category (
        title: "Science: Mathematics",
        value: 19
    ),
    Category (
        title: "Mythology",
        value: 20
    ),
    Category (
        title: "Sports",
        value: 21
    ),
    Category (
        title: "Geography",
        value: 22
    ),
    Category (
        title: "History",
        value: 23
    ),
    Category (
        title: "Politics",
        value: 24
    ),
    Category (
        title: "Art",
        value: 25
    ),
    Category (
        title: "Celebrities",
        value: 26
    ),
    Category (
        title: "Animals",
        value: 27
    ),
    Category (
        title: "Vehicles",
        value: 28
    ),
    Category (
        title: "Entertainment: Comics",
        value: 29
    ),
    Category (
        title: "Science: Gadgets",
        value: 30
    ),
    Category (
        title: "Entertainment: Japanese Anime & Manga",
        value: 31
    ),
    Category (
        title: "Entertainment: Cartoon & Animations",
        value: 32
    )
]
