//
//  StatsView.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 9/27/22.
//

import SwiftUI

struct StatsView: View {
    @EnvironmentObject var dataModel: NerdleDataModel
    
    var counterWidth: CGFloat {
        return dataModel.screenWidth * 0.2
    }
    
    var winPercentage: Int {
        if dataModel.stats.totalGames != 0 {
            let percentage = dataModel.stats.totalWins / dataModel.stats.totalGames
            return percentage * 100
        } else {
            return 0
        }
    }
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Spacer()
                Button {
                    withAnimation {
                        dataModel.showStats = false
                    }
                } label: {
                    Text("X")
                }
            }
            Text("STATISTICS")
                .font(.headline)
                .fontWeight(.bold)
                .padding(.bottom, 12)
            HStack(alignment: .top, spacing: 0) {
                StatCounterView(label: "Played", value: dataModel.stats.totalGames)
                    .frame(width: counterWidth)
                    .fixedSize()
                StatCounterView(label: "Win %", value: winPercentage)
                    .frame(width: counterWidth)
                    .fixedSize()
                StatCounterView(label: "Current Streak", value: dataModel.stats.currentStreak)
                    .frame(width: counterWidth)
                    .fixedSize()
                StatCounterView(label: "Best Streak", value: dataModel.stats.highestStreak)
                    .frame(width: counterWidth)
                    .fixedSize()
            }
            .padding(.bottom, 12)
            Text("GUESS DISTRIBUTION")
                .font(.headline)
                .fontWeight(.bold)
                .padding(.bottom, 12)
            StatsGraphView()
                .padding(.bottom, 12)
            HStack {
                StatsButtonView(label: "New Game", width: dataModel.screenWidth * 0.35, bgColor: .correct) {
                    dataModel.newGame()
                    withAnimation {
                        dataModel.showStats = false
                    }
                }
                .disabled(dataModel.gameStatus == .inPlay)
                
                Divider()
                    .background(Color.incorrect)
                    .padding(.horizontal, 8)
                    .frame(height: 45)
                
                StatsButtonView(label: "Share", icon: "square.and.arrow.up", width: dataModel.screenWidth * 0.35, bgColor: .blue) {
                    // some action
                }
                
            }
            Spacer()
        }
//        .padding(.horizontal, dataModel.screenWidth * 0.1)
        .padding()
        .frame(width: dataModel.screenWidth * 0.9, height: dataModel.screenWidth * 1.3)
        .background(RoundedRectangle(cornerRadius: 8)
            .fill(Color.systemBackground)
            .shadow(color: .black.opacity(0.3), radius: 6, x: 2, y: 2)
        )
    }
}

struct StatCounterView: View {
    var label: String
    var value: Int
    
    var body: some View {
        VStack {
            Text(String(value))
                .font(.largeTitle)
            Text(label)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .lineLimit(2, reservesSpace: true)
        }
    }
}

struct StatsButtonView: View {
    let label: String
    var icon: String?
    let width: CGFloat
    let bgColor: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                if let iconName = icon {
                    Image(systemName: iconName)
                }
                Text(label)
            }
            .fontWeight(.semibold)
            .frame(width: width , height: 50)
            .background(bgColor)
            .foregroundColor(.white)
            .cornerRadius(5)
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
            .environmentObject(NerdleDataModel())
    }
}
