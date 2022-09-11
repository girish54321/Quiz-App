//
//  GlobalState.swift
//  Quiz App
//
//  Created by Girish Parate on 13/06/22.
//

import SwiftUI
import WidgetKit

class AppStateStorage: ObservableObject {
    @Published var isLoadingViewShowing : Bool = false
    @Published var userScore: HighScore = HighScore(score: "0", scoreNumber: 0)
    @AppStorage(appStorageKey, store: UserDefaults(suiteName: appStorageKey))
    var appData : Data = Data()
    
    init() {
        print("i will updagt the mark i am the best")
        getUserScore()
    }
    
    func getUserScore(){
        if let data = try? JSONDecoder().decode(HighScore.self, from: appData) {
            updateUserScore(data: data)
        }
    }
    
    func toogleLoading()  {
        withAnimation {
            isLoadingViewShowing.toggle()
        }
    }
    
    func updateUserScore(data: HighScore){
        if let userData = try? JSONEncoder().encode(data) {
            self.appData = userData
            WidgetCenter.shared.reloadTimelines(ofKind: "Quiz_App_widget")
        }
        withAnimation {
            userScore = data
        }
    }
}
