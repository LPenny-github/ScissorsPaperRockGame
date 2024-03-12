//
//  ContentView.swift
//  ScissorsPaperRockGame
//
//  Created by dev on 2024/3/11.
//

import SwiftUI

enum Choices: String, CaseIterable {
    case Paper = "🖐️", Scissors = "✌️", Rock = "✊"
}

struct ContentView: View {
    
    @State var opponentChoice: Choices = Choices.allCases.first!
    @State var showOpponentChoice = false
    
    @State var gameResaultMessage = ""
    @State var showGameResaultMessage = false
    
    @State var wins = 0
    @State var round = 0
    @State var userPaperCount = 0
    @State var userScissorsCount = 0
    @State var userRockCount = 0
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                VStack {
                    if !showOpponentChoice {
                        Text("🤖")
                            .font(.system(size: 100))
                    }else {
                        Text(opponentChoice.rawValue)
                            .font(.system(size: 100))
                    }
                }.frame(width: geo.size.width, height: geo.size.height/2)
                VStack {
                    Text("Make your choices~")
                        .padding()
                    HStack(spacing: 5) {
                        ForEach(Choices.allCases, id:\.self){ choice in
                            Button(action: {
                                // start a round
                                round += 1
                                
                                // generate opponent choice
                                let index = Int.random(in: 0...Choices.allCases.count-1)
                                opponentChoice = Choices.allCases[index]
                                
                                // show opponent choice
                                showOpponentChoice = true
                                
                                // check if win
                                CheckGameResault(playerChoice: choice)
                                
                                // 紀錄使用者出什麼
                                CalculateUserPreference(userChoice: choice)
                            }){
                                Text(choice.rawValue)
                            }.font(.system(size: geo.size.width/CGFloat(Choices.allCases.count)))
                        }
                    }
                    HStack{ Spacer()}
                    HStack{
                        Spacer()
                        Text("Wins: \(wins)")
                        Spacer()
                        Text("rounds: \(round)")
                        Spacer()
                    }
                    HStack{ Spacer()}
                    HStack{
                        Spacer()
                        Text("papers: \(userPaperCount)")
                        Spacer()
                        Text("scissors: \(userScissorsCount)")
                        Spacer()
                        Text("rocks: \(userRockCount)")
                        Spacer()
                    }
                }.frame(width: geo.size.width, height: geo.size.height/2)
            }
        }
        .alert("Resault is \(gameResaultMessage)", isPresented: $showGameResaultMessage){
            Button("Play again!", role: .cancel){
                showOpponentChoice = false
            }
        }
    }
    func CalculateUserPreference(userChoice: Choices){
        switch userChoice {
        case .Paper:
            userPaperCount += 1
        case .Scissors:
            userScissorsCount += 1
        case .Rock:
            userRockCount += 1
        }
    }
    
    func CheckGameResault(playerChoice: Choices){
        switch playerChoice {
        case .Paper:
            if opponentChoice == .Scissors {
                gameResaultMessage = "Lose"
            } else if opponentChoice == .Rock {
                gameResaultMessage = "Win"
                wins += 1
            } else {
                gameResaultMessage = "Tie"
            }
        case .Scissors:
            if opponentChoice == .Rock {
                gameResaultMessage = "Lose"
            } else if opponentChoice == .Paper {
                gameResaultMessage = "Win"
                wins += 1
            } else {
                gameResaultMessage = "Tie"
            }
        case .Rock:
            if opponentChoice == .Paper {
                gameResaultMessage = "Lose"
            } else if opponentChoice == .Scissors {
                gameResaultMessage = "Win"
                wins += 1
            } else {
                gameResaultMessage = "Tie"
            }
        }
        showGameResaultMessage = true
    }
}

#Preview {
    ContentView()
}
