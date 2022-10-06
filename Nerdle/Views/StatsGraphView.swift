//
//  StatsGraphView.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 10/5/22.
//

import SwiftUI

struct StatsGraphView: View {
    @EnvironmentObject var dataModel: NerdleDataModel
    
    @State var maxWidth: CGFloat = 0

    var barHeight: CGFloat {
        return dataModel.screenWidth * 0.06
    }
    
    var maxValue: Int {
        if let highestValue = dataModel.stats.wins.max() {
            return highestValue
        } else {
            return 0
        }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            ForEach (0..<6) { i in
                let currentStat = dataModel.stats.wins[i]
                let barWidth = getBarWidth(barIndex: i)
                
                HStack {
                    Text("\(i + 1)")
                        .frame(width: barHeight * 0.5, height: barHeight)
                    if currentStat > 0 && currentStat == maxValue {
                        GeometryReader { geometry in
                            BarView(counter: currentStat, height: barHeight, width: barWidth, color: .correct)
                                .onAppear {
                                    maxWidth = geometry.size.width
                                }
                        }
                    } else {
                        BarView(counter: currentStat, height: barHeight, width: barWidth, color: .incorrect)
                    }
                    Spacer()
                }
            }
        }
    }
    
    func getBarWidth(barIndex i: Int) -> CGFloat {
        if dataModel.stats.wins[i] == 0 {
            return barHeight * 1.2
        }
        
        if let maxValue = dataModel.stats.wins.max() {
            if dataModel.stats.wins[i] == maxValue {
                return .infinity
            } else {
                let multiplier = CGFloat(dataModel.stats.wins[i]) / CGFloat(maxValue)
                return multiplier * maxWidth
            }
        } else {
            return 0
        }
    }
}

//MARK: - BAR VIEW

struct BarView: View {
    let counter: Int
    let height: CGFloat
    let width: CGFloat
    let color: Color
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(maxWidth: width, maxHeight: height)
            .overlay(alignment: counter > 0 ? .trailing : .center) {
                Text("\(counter)")
                    .foregroundColor(.white)
                    .padding(.trailing, counter > 0 ? height * 0.5 : 0)
            }
    }
}

struct StatsGraphView_Previews: PreviewProvider {
    static var previews: some View {
        StatsGraphView()
            .environmentObject(NerdleDataModel())
    }
}
