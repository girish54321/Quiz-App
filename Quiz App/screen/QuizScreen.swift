//
//  QuziScreen.swift
//  Quiz App
//
//  Created by Girish Parate on 11/06/22.
//

import SwiftUI

struct QuizScreen: View {
    
    @State var quiaData: QuestionsBase? = Bundle.main.decode("data.json")
    @State private var currentIndex = 0
    @State private var lastAnswer = ""
    @State private var totalScore = 0
    @State private var disabled: Bool = false
    @State private var completed: Bool = false
    
    @Environment(\.presentationMode) var presentation
    
    @EnvironmentObject var appStateStorage: AppStateStorage
    
    var body: some View {
        VStack {
            if completed == false {
                ScrollView {
                    VStack (alignment: .center, spacing: 22) {
                        TabView(selection: $currentIndex){
                            ForEach ((quiaData?.results?.indices)!,id:\.self) { item in
                                Quxtionview(
                                    difficulty:quiaData!.results![item].difficulty!,
                                    mainText:"\(quiaData?.results![item].question! ?? "")")
                                .tag(item)
                                .frame(minWidth: 200, idealWidth: 200, maxWidth: 500, minHeight: 200, idealHeight: 200,  alignment: .center)
                                .background(Color.indigo)
                                .cornerRadius(8)
                                .padding()
                            }
                        }
                        .disabled(true)
                        .tabViewStyle(.page(indexDisplayMode: .always))
                        .frame(height:210)
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                    }
                    VStack(spacing:24){
                        ForEach((quiaData?.results?[currentIndex].incorrect_answers! ?? [""]) ,id:\.self) { item in
                            let correctAnswer = quiaData?.results![currentIndex].correct_answer
                            let isRight = item == correctAnswer ? true : false
                            Button(action: {
                                withAnimation {
                                    lastAnswer = item
                                }
                                if(isRight == true){
                                    withAnimation {
                                        totalScore += 10
                                    }
                                }
                                withAnimation {
                                    disabled = true
                                }
                                goToNextQuestion()
                            }, label: {
                                HStack {
                                    Spacer()
                                    Text(UIHelper().formateHelptext(text: item))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                                .frame(minWidth: 200, idealWidth: 200, maxWidth: 500, minHeight: 50, idealHeight: 50, maxHeight: 50, alignment: .center)
                                .background(lastAnswer == item ? isRight ? Color.green : Color.red : disabled && item == correctAnswer ?  Color.green : Color.indigo
                                )
                                .cornerRadius(8)
                            })
                        }
                        Text("\(totalScore)/%")
                            .font(.largeTitle)
                            .foregroundColor(.green)
                            .fontWeight(.heavy)
                            .padding()
                            .padding(.top,22)
                    }
                    .disabled(disabled)
                    .onChange(of: currentIndex) { newValue in
                        withAnimation {
                            currentIndex = newValue
                        }
                    }
                    .padding()
                }
                .navigationTitle(quiaData?.results![currentIndex].category! ?? "")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Skip") {
                            goToNextQuestion(withTimer: false)
                        }
                    }
                }
            } else {
                LottieView(action: goBack)
            }
        }
        .onAppear {
            for (index, _) in quiaData!.results!.enumerated() {
                let rightAns = quiaData?.results![index].correct_answer
                quiaData!.results![index].incorrect_answers!.append(rightAns ?? "404")
                quiaData!.results![index].incorrect_answers = quiaData!.results![index].incorrect_answers!.shuffled()
            }
        }
    }
    
    func goBack () {
        print("Go back")
    }
    
    func goToNextQuestion(withTimer: Bool = true){
        if(isLastQuestion()){
          DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
              let newHighScore = appStateStorage.userScore.scoreNumber + totalScore
              let data = HighScore(score: "\(newHighScore)", scoreNumber: newHighScore)
              appStateStorage.updateUserScore(data: data)
                withAnimation {
                    disabled = true
                    completed = true
                }
            }
            return
        }
        
        if(!withTimer) {
            moveToNext()
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            moveToNext()
        }
    }
    
    func moveToNext() {
        withAnimation {
            currentIndex += 1
            lastAnswer = ""
            disabled = false
        }
    }
    
    func isLastQuestion() -> Bool {
        return ((quiaData?.results!.count)! - 1 == currentIndex) ? true : false
    }
    
    struct Quxtionview: View {
        var difficulty: String?
        var mainText: String?
        var body: some View {
            HStack {
                VStack (alignment: .leading,spacing: 18) {
                    Text("Difficulty: \(difficulty!.uppercased())")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(UIHelper().formateHelptext(text: mainText ?? ""))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                }
                .padding()
                Spacer()
            }
        }
    }
}

struct QuizScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QuizScreen()
        }
    }
}
