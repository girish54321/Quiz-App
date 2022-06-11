//
//  ContentView.swift
//  Quiz App
//
//  Created by Girish Parate on 10/06/22.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    
    @State private var quiaData: QuestionsBase?
    
    @State private var isShowingDetailView = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: QuziScreen(quiaData: quiaData), isActive: $isShowingDetailView) { EmptyView() }
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
        AF.request("https://opentdb.com/api.php?amount=10",method: .get).validate().responseDecodable(of: QuestionsBase.self) { (response) in
            guard let data = response.value else {
                return
            }
            if (data.response_code != 0){
                print("error")
                return
            }
            print(data)
            withAnimation {
                quiaData = data
                isShowingDetailView = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
