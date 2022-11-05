//
//  WelcomeScreen.swift
//  Quiz App
//
//  Created by Girish Parate on 13/06/22.
//

import SwiftUI
import Alamofire

struct WelcomeScreen: View {
    
    @State private var quiaData: QuestionsBase?
    @State private var isShowingDetailView = false
    @EnvironmentObject var appStateStorage: AppStateStorage
    
    var body: some View {
        NavigationView {
            VStack {
                Group {
                    HStack {
                    Text("Your Best score - ")
                        Spacer()
                        Text(appStateStorage.userScore.score)
                            .foregroundColor(Color.indigo)
                            .fontWeight(.heavy)
                    }
                }
                .padding()
                .font(.title)
            
                
                NavigationLink(destination: QuizScreen(quiaData: quiaData), isActive: $isShowingDetailView) { EmptyView() }
                Spacer()
                NavigationLink(destination: QuizConfig()) {
                    VStack(alignment: .center, spacing: 22) {
                        Image("select")
                            .imageModifier()
                            .frame(width: 120, height: 120, alignment: .center)
                        Text("Create Your Own!")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                }
                Spacer()
                Button(action: {
                    getQutions()
                }, label: {
                    VStack(alignment: .center, spacing: 22) {
                        Image("shuffle")
                            .imageModifier()
                            .frame(width: 120, height: 120, alignment: .center)
                        Text("Any Topic")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                })
                Spacer()
            }
            .navigationTitle("Welcome to Quiz")
        }
    }
    
    func getQutions() {
        appStateStorage.isLoadingViewShowing = true
        AF.request("https://opentdb.com/api.php?amount=10",method: .get).validate().responseDecodable(of: QuestionsBase.self) { (response) in
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
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
            .environmentObject(AppStateStorage())
    }
}

