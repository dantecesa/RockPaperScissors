//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Dante Cesa on 1/10/22.
//

import SwiftUI

struct ContentView: View {
    let possibleMoves: [String] = ["🪨 Rock", "📃 Paper", "✂️ Scissors"]
    @State var currentRound: Int = 0
    var maxRounds: Int = 5
    @State var gameOver: Bool = false
    @State var showAlert: Bool = false
    @State var alertText: String = ""
    @State var secondaryAlertText: String = ""
    @State var computerGuess: Int = Int.random(in: 0...2)
    @State var numCorrect: Int = 0
    let winMessage: String = "You won!"
    let loseMessage: String = "Sorry, you lost!"
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        Text("First to \(maxRounds) wins!")
                        Text("Current score is: \(numCorrect)/\(currentRound)")
                    } header: {
                        Text("Welcome!")
                    }
                    
                    Section {
                        Text("\(possibleMoves[computerGuess])")
                    } header: {
                        Text("Computer plays…")
                    }
                    Section {
                        ForEach(0..<possibleMoves.count) { index in
                            Button(action: {
                                makeGuess(atIndex: index)
                            }, label: {
                                Text(possibleMoves[index])
                            })
                        }
                    } header : {
                        Text("You pick…")
                    }.navigationTitle("Rock, Paper, Scissors")
                }
            }.alert("Game Over!", isPresented: $gameOver) {
                Button("Try again") { reset() }
            } message: {
                Text("Your final score was: \(numCorrect)/\(maxRounds)")
                Text(secondaryAlertText)
            }.alert(alertText, isPresented: $showAlert) {
                Button("Continue") {  }
            } message: {
                Text(secondaryAlertText)
            }
        }
    }
    
    func makeGuess(atIndex index: Int) {
        currentRound += 1
        if currentRound == maxRounds {
            gameOver = true
        } else {
            switch possibleMoves[index] {
            case let x where x == possibleMoves[computerGuess]:
                alertText = "It's a draw!"
                secondaryAlertText = ""
            case let x where x == "🪨 Rock" && possibleMoves[computerGuess] == "📃 Paper":
                alertText = loseMessage
                secondaryAlertText = "📃 Paper covers 🪨 Rock."
            case let x where x == "🪨 Rock" && possibleMoves[computerGuess] == "✂️ Scissors":
                alertText = winMessage
                secondaryAlertText = "🪨 Rock smashes ✂️ Scissors!"
                numCorrect += 1
            case let x where x == "✂️ Scissors" && possibleMoves[computerGuess] == "📃 Paper":
                alertText = winMessage
                secondaryAlertText = "✂️ Scissors cut 📃 Paper!"
                numCorrect += 1
            case let x where x == "✂️ Scissors" && possibleMoves[computerGuess] == "🪨 Rock":
                alertText = loseMessage
                secondaryAlertText = "🪨 Rock smashes ✂️ Scissors."
            case let x where x == "📃 Paper" && possibleMoves[computerGuess] == "🪨 Rock":
                alertText = winMessage
                secondaryAlertText = "📃 Paper covers 🪨 Rock!"
                numCorrect += 1
            case let x where x == "📃 Paper" && possibleMoves[computerGuess] == "✂️ Scissors":
                alertText = loseMessage
                secondaryAlertText = "✂️ Scissors cut 📃 Paper."
            default:
                print("Something went wrong")
            }
            showAlert = true
        }
        computerGuess = Int.random(in: 0...2)
    }
    
    func reset() {
        gameOver = false
        currentRound = 0
        numCorrect = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
