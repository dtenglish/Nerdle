//
//  StatsView.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 9/27/22.
//

import SwiftUI

struct StatsView: View {
    @EnvironmentObject var dataModel: NerdleDataModel
    
    var rem: CGFloat {
        return dataModel.screenWidth * 0.1
    }
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Spacer()
                Button {
                    dataModel.showStats = false
                } label: {
                    Image(systemName: "multiply")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.accentColor)
                }
                .padding(.top, rem * 0.25)
            }
            Text("STATISTICS")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.bottom, 8)
            HStack(alignment: .top, spacing: 0) {
                StatCounterView(label: "Played", value: dataModel.stats.totalGames)
                    .frame(width: rem * 2)
                    .fixedSize()
                StatCounterView(label: "Win %", value: dataModel.stats.winPercentage)
                    .frame(width: rem * 2)
                    .fixedSize()
                StatCounterView(label: "Current Streak", value: dataModel.stats.currentStreak)
                    .frame(width: rem * 2)
                    .fixedSize()
                StatCounterView(label: "Best Streak", value: dataModel.stats.highestStreak)
                    .frame(width: rem * 2)
                    .fixedSize()
            }
            .padding(.bottom, 24)
            Text("GUESS DISTRIBUTION")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.bottom, 12)
            StatsGraphView()
                .frame(maxWidth: .infinity)
                .padding(.bottom, dataModel.gameStatus == .inPlay ? 24 : 12)
            if dataModel.gameStatus != .inPlay {
                HStack {
                    Button {
                        dataModel.newGame()
                        withAnimation {
                            dataModel.showStats = false
                        }
                    } label: {
                        HStack {
                            Text("New Game")
                        }
                    }
                    .fontWeight(.semibold)
                    .frame(width: rem * 3.5 , height: 50)
                    .background(Color.correct)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    
                    Divider()
                        .background(Color.incorrect)
                        .padding(.horizontal, 8)
                        .frame(height: 45)
                    
                    ShareLink(item: dataModel.getResult())
                        .fontWeight(.semibold)
                        .frame(width: rem * 3.5 , height: 50)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
                .padding(.bottom, 12)
            }
        }
        .padding(.vertical, rem * 0.25)
        .padding(.horizontal, rem * 0.5)
        .frame(width: rem * 9)
        .fixedSize()
        .background(RoundedRectangle(cornerRadius: 8)
            .fill(Color(UIColor.systemGray6))
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

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
            .environmentObject(NerdleDataModel())
    }
}
