//
//  QuziScreen.swift
//  Quiz App
//
//  Created by Girish Parate on 11/06/22.
//

import SwiftUI
import HTMLEntities

struct QuziScreen: View {
    
    var quiaData: QuestionsBase?
    @State private var currentIndex = 0
    @State private var lastAnswer = ""
    @State private var totalScrore = 0
    
    var body: some View {
        ScrollView {
            VStack {
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
                        .frame(height:160)
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
                ForEach((quiaData?.results![currentIndex].incorrect_answers! ?? [""]) + [quiaData?.results![currentIndex].correct_answer],id:\.self) { item in
                    let correctAnswer = quiaData?.results![currentIndex].correct_answer
                    let isRight = item == correctAnswer ? true : false
                    Button(action: {
                        withAnimation {
                            lastAnswer = item!
                        }
                        if(isRight == true){
                            print("Right Ans")
                            withAnimation {
                                totalScrore += 10
                            }
                        } else {
                            print("worng")
                        }
                        goToNextQution()
                    }, label: {
                        HStack {
                            Spacer()
                            Text(item!)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .frame(height:50)
                        .background(lastAnswer == item ? isRight ? Color.green : Color.red : Color.indigo)
                        .cornerRadius(8)
                    })
                }
                Text("\(totalScrore)/%")
                    .font(.largeTitle)
                    .foregroundColor(.green)
                    .fontWeight(.heavy)
                    .padding()
                    .padding(.top,22)
            }
            .onChange(of: currentIndex) { newValue in
                print(currentIndex)
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
                    print("Help tapped!")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Skip") {
                    print("Help tapped!")
                }
            }
        }
        
    }
    
    func goToNextQution(){
        if((quiaData?.results!.count)! - 1 == currentIndex){
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                currentIndex += 1
            }
        }
    }
}

struct QuziScreen_Previews: PreviewProvider {
    static var previews: some View {
        QuziScreen()
    }
}
