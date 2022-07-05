//
//  QuziScreen.swift
//  Quiz App
//
//  Created by Girish Parate on 11/06/22.
//

import SwiftUI
import HTMLEntities

struct QuizScreen: View {
    
    @State var quiaData: QuestionsBase? = Bundle.main.decode("data.json")
    @State private var currentIndex = 0
    @State private var lastAnswer = ""
    @State private var totalScore = 0
    @State private var disabled: Bool = false
    @State private var completed: Bool = false
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            if completed == false {
                ScrollView {
                    VStack (alignment: .center, spacing: 22) {
                        TabView(selection: $currentIndex){
                            ForEach ((quiaData?.results?.indices)!,id:\.self) { item in
                                HStack {
                                    VStack (alignment: .leading,spacing: 18) {
                                        Text("Difficulty: \(quiaData!.results![item].difficulty!.uppercased())")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text("\(quiaData?.results![item].question! ?? "")".htmlUnescape())
                                            .fontWeight(.heavy)
                                            .tag(item)
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                    Spacer()
                                }
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
                                    Text(item)
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
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Exit") {
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Skip") {
                            goToNextQuestion()
                        }
                    }
                }
            } else {
                LottieView(action: goBack)
            }
        }
        .onAppear {
            for (index, element) in quiaData!.results!.enumerated() {
                let rightAns = quiaData?.results![index].correct_answer
                quiaData!.results![index].incorrect_answers!.append(rightAns ?? "404")
                quiaData!.results![index].incorrect_answers = quiaData!.results![index].incorrect_answers!.shuffled()
            }
        }
    }
    
    func goBack () {
        print("Go back")
    }
    
    func goToNextQuestion(){
        if(isLastQuestion()){
            withAnimation {
                disabled = true
                completed = true
            }
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                currentIndex += 1
                lastAnswer = ""
                disabled = false
            }
        }
    }
    
    func isLastQuestion() -> Bool {
        return ((quiaData?.results!.count)! - 1 == currentIndex) ? true : false
    }
}

struct QuizScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QuizScreen()
        }
    }
}
