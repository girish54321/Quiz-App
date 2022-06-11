//
//  QuizConfig.swift
//  Quiz App
//
//  Created by Girish Parate on 10/06/22.
//

import SwiftUI

struct QuizConfig: View {
    @State private var selection: Category = CategoryList[0]
    @State private var selectedDifficulty: Difficulty = DifficultyList[0]
    @State private var selectedQuestionyType: QuestionyType = QuestionyTypeList[0]
    @State private var name = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Create your quiz")){
                        TextField("Number of Questions", text: $name).keyboardType(.numberPad)
                        Picker("Category", selection: $selection.id) {
                            ForEach(CategoryList) { item in
                                Text(item.title)
                            }
                        }
                        Picker("Select Difficulty", selection: $selectedDifficulty.id) {
                            ForEach(DifficultyList) { item in
                                Text(item.title)
                            }
                        }
                        Picker("Select Type", selection: $selectedQuestionyType.id) {
                            ForEach(QuestionyTypeList) { item in
                                Text(item.title)
                                
                            }
                        }
                    }
                }
                Button(action: {
                    
                }, label: {
                    Text("Click Me")
                })
                .buttonStyle(RoundedRectangleButtonStyle())
                .padding()
                
            }
            .navigationTitle("Trivia API")
            //            .navigationBarTitle("Create your quiz", displayMode: .inline)
        }
    }
}

struct QuizConfig_Previews: PreviewProvider {
    static var previews: some View {
        QuizConfig()
    }
}
