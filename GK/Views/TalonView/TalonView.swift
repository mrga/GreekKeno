//
//  ContentView.swift
//  GK
//
//  Created by Branislav Mrganic on 28.6.24..
//

import SwiftUI

struct TalonView: View {
    
    @State private var viewModel = ViewModel()

    
    init(drawData: DrawData) {
        viewModel.drawData = drawData
    }
    
    var body: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .failed(let error):
            Color.clear.alert(isPresented: $viewModel.showingAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(error),
                    dismissButton: .default(Text("ok"))
                )
            }
        case .loaded(let drawData):
            content(drawData)
        }
    }
    
    
    private func content(_ drawData: DrawData) -> some View {
        VStack(alignment: .leading)  {
            HStack {
                Image("flag")
                Text("Greek keno (20/80)")
                    .font(.headline)
            }
            Divider()
                .frame(height: 2)
                .overlay(.gray.opacity(0.1))
            HStack {
                Text("Draw time:")
                Text("\((drawData.drawTime/1000).format(.hoursMinutes))h")
                Text("|")
                Text("Round:")
                Text(verbatim: "\(drawData.drawId)")
            }
            .font(.footnote)
            Divider()
            HStack {
                Spacer()
                Text("Bet remaining time:")
                    .font(.footnote)
                CountdownView(date: Date(timeIntervalSince1970: drawData.drawTime / 1000)) {
                    
                }
                    .font(.title3)
                    .padding(.bottom, -4)
            }
            Divider()
                .frame(height: 2)
                .overlay(.gray.opacity(0.1))
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Odds")
                        .font(.subheadline)
                    
                    Divider()
                    
                    HStack(spacing: 0) {
                        ForEach (1...viewModel.odds.count, id:\.self) { index in
                            let selectedCount = min(viewModel.selectedNumbers.count, 8)
                            let isSelected = index == selectedCount
                            VStack {
                                Text("\(index)")
                                Divider()
                                    .padding(0)
                                Text(viewModel.odds[index-1].maximum2)
                            }
                            .fontWeight(isSelected ? .bold : .thin)
                            .font(.system(size: 11))
                        }
                        
                    }
                    .padding(.leading, -10)
                }
                Spacer(minLength: 20)
                
                HStack {
                    Text("No. of selected numbers:")
                    Text("\(viewModel.selectedNumbers.count)")
                    Spacer()
                }
                .padding(.leading, 8)
                .font(.caption)
                
                FlexibleGridView(items: Array(1...80), itemPerRow: 8) { i, number in
                    let colorIndex = i % 8
                    NumberView(number: number, isSelected: Binding(
                        get: { viewModel.selectedNumbers.contains(number) },
                        set: { isSelected in
                            if isSelected {
                                if viewModel.selectedNumbers.count < 15 {
                                    viewModel.selectedNumbers.append(number)
                                }
                            } else {
                                viewModel.selectedNumbers.removeAll { $0 == number }
                            }
                        }
                    ), ringColor:viewModel.ringColors[colorIndex]) {
                        
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 6)
                    .border(.gray.opacity(0.2))
                }
                Spacer()
            }
        }
        .padding()
        
    }
    

    
    
}

#Preview {
    TalonView(drawData: DrawData(gameId: 1100, drawId: 111, drawTime: 262626626182))
}
