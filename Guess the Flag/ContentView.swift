//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Rob Downing on 10/21/25.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy",
        "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"
    ].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreValue = 0
    @State private var questionCount = 0
    @State private var gameOver = false
    
    var body: some View {
        ZStack {
            // 🎨 Background gradient
            RadialGradient(
                stops: [
                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                    .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
                ],
                center: .top,
                startRadius: 200,
                endRadius: 400
            )
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    // 🏴‍☠️ Flag buttons
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(country: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                // 🧮 Live score label
                Text("Score: \(scoreValue)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        // 🧾 Alert for normal scoring
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(scoreValue)")
        }
        // 🏁 Final alert after 8 questions
        .alert("Game Over", isPresented: $gameOver) {
            Button("Restart", action: resetGame)
        } message: {
            Text("Your final score was \(scoreValue) out of 8.")
        }
    }
    
    // MARK: - Game Logic
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            scoreValue += 1
        } else {
            scoreTitle = "Wrong! That’s the flag of \(countries[number])"
        }
        
        questionCount += 1
        
        if questionCount == 8 {
            gameOver = true
        } else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        scoreValue = 0
        questionCount = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
