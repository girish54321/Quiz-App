//
//  QuziScreen.swift
//  Quiz App
//
//  Created by Girish Parate on 11/06/22.
//

import SwiftUI

struct QuziScreen: View {
    
    let data: Json4Swift_Base = Bundle.main.decode("data.json")
    
    @State private var currentIndex = 0
    @State private var lastAnswer = ""
    @State private var totalScrore = 0
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    TabView(selection: $currentIndex){
                        ForEach ((data.results?.indices)!,id:\.self) { item in
                            HStack {
                                VStack (alignment: .leading,spacing: 18) {
                                    Text("Difficulty: \(data.results![item].difficulty!.uppercased())")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text(data.results![item].question!)
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
                    ForEach(data.results![currentIndex].incorrect_answers! + [data.results![currentIndex].correct_answer],id:\.self) { item in
                        let correctAnswer = data.results![currentIndex].correct_answer
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
            .navigationTitle(data.results![currentIndex].category!)
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
    }
    
    func goToNextQution(){
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
