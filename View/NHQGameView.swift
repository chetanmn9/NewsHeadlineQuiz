//
//  ContentView.swift
//  NewsHeadlineQuiz
//
//  Created by Chetan Melkote nagaraj on 7/9/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import SwiftUI

struct NHQGameView: View {
    @ObservedObject var ncgameVM = NHQGameViewModel()
    @State var questions: [Items] = []
    @State var questionStartIndex = 0
    @State var isQuestion: Bool = true
    @State var score = 0
    @State var isCorrectAnswer: Bool = false

    
    init() {
        //Navigation Bar initialization
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().tintColor = .white
    }
    
    private func startGame() {
        
        // load news feeds from API call
        
        if questions.isEmpty {
            
            self.ncgameVM.fetchGameQuestions{ (questions) in
                self.questions = questions
            }
        }
        
        //Reset score and questions index
        score = 0
        questionStartIndex = 0
        isQuestion = true
        
    }
    
    var body: some View {
        
        NavigationView {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1))]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                VStack{
                    NavigationLink(destination: questionsList(questionItems: $questions, questionIndex: $questionStartIndex, score: $score, isQuestion: $isQuestion, isCorrectAnswer: $isCorrectAnswer).onAppear() { self.startGame() }) {
                        
                        //Start new game button
                        Text("Start New Game")
                            .font(.custom("Helvetica Neue", size: 20))
                            .font(.title)
                            .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(40)
                            
                        
                    }.navigationBarTitle("Guess the headlines!", displayMode: .inline)
                    
                    Spacer()
                        .frame(height: 10)
                    
                    
                    
                    NavigationLink(destination: questionsList(questionItems: $questions, questionIndex: $questionStartIndex, score: $score, isQuestion: $isQuestion, isCorrectAnswer: $isCorrectAnswer).onAppear()) {
                        if !questions.isEmpty {
                            Text(" Resume Game  ")
                                .font(.custom("Helvetica Neue", size: 20))
                                .font(.title)
                                .padding()
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(40)
                        }
                    }
                }
            }
        }
        
    }
}

struct questionsList: View {
    @Binding var questionItems: [Items]
    @Binding var questionIndex: Int
    @Binding var score : Int
    @Binding var isQuestion: Bool
    @Binding var isCorrectAnswer: Bool
    @State var startCorrectAnimation = false
    @State var startWrongAnimation = false
    
    
    func updateScore(tappedAnswer: Int) {
        
        if questionItems[questionIndex].correctAnswerIndex == tappedAnswer {
            score += 2
            isCorrectAnswer = true
            startCorrectAnimation = true
        } else {
            if score != 0 {
                score -= 1
            }
            isCorrectAnswer = false
            startWrongAnimation = true
        }
        isQuestion = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.startCorrectAnimation = false
            self.startWrongAnimation = false
        }
    }
    
    func nextQuestion() {
        
        self.questionIndex += 1
        isQuestion = true
    }
    
    var body: some View {
        ZStack {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1))]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                VStack{
                    
                    if !questionItems.isEmpty {
                        
                        VStack {
                            
                            Spacer()
                            
                            HStack {
                                
                                VStack{
                                    
                                    Spacer()
                                    
                                    Text("\(questionItems[questionIndex].section)".capitalized).frame(minWidth: 0, maxWidth: 190, minHeight: 10, maxHeight: 15)
                                        .font(.custom("Helvetica Neue", size: 20))
                                        .font(.title)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                                        .cornerRadius(5)
                                    
                                    Spacer()
                                    
                                    if isQuestion == true {
                                        
                                        Spacer()
                                        
                                        Text("Guess the headline!").frame(minWidth: 0, maxWidth: 190, minHeight: 10, maxHeight: 15)
                                            .font(.custom("Helvetica Neue", size: 20))
                                            .font(.title)
                                            .padding()
                                            .foregroundColor(.white)
                                            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                                            .cornerRadius(5)
                                        
                                    } else {
                                        if isCorrectAnswer == true {
                                            
                                            Spacer()
                                            
                                            Text("Correct! 2 points! 🙌").frame(minWidth: 0, maxWidth: 190, minHeight: 10, maxHeight: 15)
                                                .font(.custom("Helvetica Neue", size: 20))
                                                .font(.title)
                                                .padding()
                                                .foregroundColor(.white)
                                                .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)), Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                                                .cornerRadius(5)
                                            
                                        } else {
                                            
                                            Spacer()
                                            
                                            Text("Incorrect 🙁").frame(minWidth: 0, maxWidth: 190, minHeight: 10, maxHeight: 15)
                                                .font(.custom("Helvetica Neue", size: 20))
                                                .font(.title)
                                                .padding()
                                                .foregroundColor(.white)
                                                .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)), Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                                                .cornerRadius(10)
                                            
                                        }
                                    }
                                }
                                
                                Spacer()
                                    .frame(width: 30)
                                
                                VStack {
                                    Text("Score")
                                    Text("\(score)")
                                }
                                .font(.custom("Helvetica Neue", size: 20))
                                .font(.title)
                                .padding()
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .background(Circle()
                                .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1))]), startPoint: .bottom, endPoint: .top))
                                .frame(width: 110, height: 110))
                                Spacer()
                                    .frame(width: 10)
                                
                            }
                            
                            Spacer()
                            
                            URLImage(url: questionItems[questionIndex].imageUrl)
                                .frame(width: 350, height: 210)
                                .scaledToFit()
                                .clipped()
                                .cornerRadius(10)
                            
                        }
                        
                        
                        
                        VStack{
                            
                            if isQuestion == true {
                                
                                Button("\(questionItems[questionIndex].headlines[0].description)", action: { self.updateScore(tappedAnswer: 0) } )
                                    .frame(minWidth: 0, maxWidth: 300, minHeight: 45)
                                    .font(.custom("Helvetica Neue", size: 16))
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(40)
                                
                                Spacer()
                                    .frame(height: 10)
                                
                                Button("\(questionItems[questionIndex].headlines[1].description)", action: { self.updateScore(tappedAnswer: 1) } )
                                    .frame(minWidth: 0, maxWidth: 300, minHeight: 45)
                                    .font(.custom("Helvetica Neue", size: 16))
                                    .font(.body)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(40)
                                
                                Spacer()
                                    .frame(height: 10)
                                
                                Button("\(questionItems[questionIndex].headlines[2].description)", action: { self.updateScore(tappedAnswer: 2) } )
                                    .frame(minWidth: 0, maxWidth: 300, minHeight: 45)
                                    .font(.custom("Helvetica Neue", size: 16))
                                    .font(.body)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(40)
                                
                                Spacer()
                                    .frame(width: 1)
                                
                                Button("Skip to Next! I give up", action: {self.nextQuestion()})
                                    .frame(minWidth: 0, maxWidth: 320, maxHeight: 30)
                                    .font(.custom("Helvetica Neue", size: 20))
                                    .font(.body)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(40)
                                
                            } else {
                                VStack {
                                    
                                    Text("\(questionItems[questionIndex].standFirst)")
                                        .multilineTextAlignment(.center)
                                        .frame(minWidth: 0, maxWidth: 330, maxHeight: 220)
                                        .font(.custom("Helvetica Neue", size: 16))
                                        .font(.body)
                                        .padding(.trailing)
                                        .foregroundColor(.white)
                                        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                                        .cornerRadius(3)
                                    
                                    Spacer()
                                    HStack {
                                        
                                        Spacer()
                                        
                                        Button("Read Article >", action: {UIApplication.shared.open(URL(string: "\(self.questionItems[self.questionIndex].storyUrl)")!)})
                                            .frame(minWidth: 0, maxWidth: 150, minHeight: 50, maxHeight: 50)
                                            .font(.custom("Helvetica Neue", size: 20))
                                            .font(.title)
                                            .padding(.leading)
                                            .foregroundColor(.white)
                                            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                                            .cornerRadius(40)
                                        
                                        Spacer()
                                            .frame(width: 15)
                                    }
                                    Spacer()
                                    
                                    Button("Next Question", action: {self.nextQuestion()})
                                        .frame(minWidth: 0, maxWidth: 320, maxHeight: 15)
                                        .font(.custom("Helvetica Neue", size: 20))
                                        .font(.title)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                                        .cornerRadius(40)
                                    
                                }
                            }
                        }
                    }
                }
            }
            VStack{
                
                Spacer()
                if startCorrectAnimation == true {
                    CorrectAnswerAnimation()
                } else if startWrongAnimation == true {
                    wrongAnswerAnimation()
                }
                
                Spacer()
                Spacer()
            }
        }
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0, maxWidth: 300, maxHeight: 15)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            .font(.title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NHQGameView()
    }
}

