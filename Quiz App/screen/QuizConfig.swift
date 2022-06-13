//
//  QuizConfig.swift
//  Quiz App
//
//  Created by Girish Parate on 10/06/22.
//

import SwiftUI
import Alamofire

struct QuizConfig: View {
    @State private var selection = 1
    
    @State private var selectedDifficulty: Difficulty = DifficultyList[0]
    @State private var selectedQuestionsType: QuestionsType = QuestionsTypeList[0]
    @State private var name = "10"
    
    @State private var categoryList: [TriviaCategories] = []
    
    @State private var quiaData: QuestionsBase?
    
    @State private var isShowingDetailView = false
    @EnvironmentObject var appStateStorage: AppStateStorage
    
    var body: some View {
        VStack {
            NavigationLink(destination: QuizScreen(quiaData: quiaData), isActive: $isShowingDetailView) { EmptyView() }
            Form {
                Section(header: Text("Create your quiz")){
                    TextField("Number of Questions", text: $name).keyboardType(.numberPad)
                    Picker("Category", selection: $selection) {
                        ForEach(categoryList.indices,id:\.self) { item in
                            Text(categoryList[item].name ?? "")
                                .tag(categoryList[item].id)
                        }
                    }
                    Picker("Select Difficulty", selection: $selectedDifficulty.id) {
                        ForEach(DifficultyList) { item in
                            Text(item.title)
                        }
                    }
                    Picker("Select Type", selection: $selectedQuestionsType.id) {
                        ForEach(QuestionsTypeList) { item in
                            Text(item.title)
                            
                        }
                    }
                }
            }
            Button(action: {
                getQuestions()
            }, label: {
                Text("Click Me")
            })
            .buttonStyle(RoundedRectangleButtonStyle())
            .padding()
            .onAppear {
                if(categoryList.isEmpty){
                    getCategory()
                }
            }
        }
        .navigationTitle("Trivia API")
    }
    
    func getQuestions() {
        appStateStorage.isLoadingViewShowing = true
        let parameters: [String: Any] = [
            "amount" : name,
            "category": categoryList[selection].id!,
            "difficulty": selectedDifficulty.value,
            "type" : selectedQuestionsType.value
        ]
        AF.request("https://opentdb.com/api.php",method: .get,parameters: parameters).validate().responseDecodable(of: QuestionsBase.self) { (response) in
            appStateStorage.isLoadingViewShowing = false
            guard let data = response.value else {
                return
            }
            if (data.response_code != 0){
                return
            }
            withAnimation {
                quiaData = data
                isShowingDetailView = true
            }
        }
    }
    
    func getCategory()  {
        appStateStorage.isLoadingViewShowing = true
        AF.request("https://opentdb.com/api_category.php",method: .get).validate().responseDecodable(of: CategoryBase.self) { (response) in
            appStateStorage.isLoadingViewShowing = false
            guard let data = response.value else {
                return
            }
            withAnimation {
                self.categoryList.append(contentsOf: data.trivia_categories!)
            }
        }
    }
    
}

struct QuizConfig_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QuizConfig()
        }
    }
}
