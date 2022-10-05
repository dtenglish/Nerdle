//
//  StatsGraphView.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 10/5/22.
//

import SwiftUI

struct StatsGraphView: View {
    @EnvironmentObject var dataModel: NerdleDataModel
    
    var barHeight: CGFloat {
        return dataModel.screenWidth * 0.06
    }
    
    var body: some View {
        VStack(spacing: 5) {
            ForEach (0..<6) { i in
                let currentStat = dataModel.stats.wins[i]
                let barWidth = getBarWidth(barIndex: i)
                HStack {
                    Text("\(i + 1)")
                        .frame(width: barHeight * 0.5, height: barHeight)
                    Rectangle()
                        .fill(Color.incorrect)
                        .frame(width: barWidth, height: barHeight)
                        .overlay() {
                            Text("\(currentStat)")
                                .foregroundColor(.white)
                        }
                    Spacer()
                }
            }
        }
    }
    
    func getBarWidth(barIndex i: Int) -> CGFloat {
        if dataModel.stats.wins[i] == 0 {
            return barHeight
        }
        
        if let maxValue = dataModel.stats.wins.max() {
            let maxWidth = dataModel.screenWidth * 0.75
            if dataModel.stats.wins[i] == maxValue {
                return maxWidth
            } else {
                let multiplier = CGFloat(dataModel.stats.wins[i]) / CGFloat(maxValue)
                return multiplier * maxWidth
            }
        } else {
            return 0
        }
    }
}

struct StatsGraphView_Previews: PreviewProvider {
    static var previews: some View {
        StatsGraphView()
            .environmentObject(NerdleDataModel())
    }
}
