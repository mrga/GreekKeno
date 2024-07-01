//
//  PastDrawResultsView.swift
//  GK
//
//  Created by Branislav Mrganic on 29.6.24..
//

import SwiftUI

struct PastDrawResultsView: View {
    
    @EnvironmentObject var services: Services
    @State private var viewModel = ViewModel()
    @State var isSelected = true
    private let ringColors = [Color.lottoYellow, Color.orange, Color.lottoRed, Color.lottoPink, Color.lottoPurple, Color.lottoLightBlue, Color.lottoGreen, Color.lottoBlue,  Color.lottoGray]
    
    init() {
        self.viewModel = viewModel
    }

    var body: some View {
        switch viewModel.state {
        case .idle:
            Color.clear.onAppear() {
                viewModel.load(networkConteroller: services.webApi)
            }
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
        case .loaded(let data):
            content(data)
        }
    }
    
    
    private func content(_ pastDraws: PastDraws) -> some View {
        ScrollView {
            ForEach(pastDraws.games, id: \.drawId) { pastDraw in
                VStack(alignment: .leading) {
                    HStack {
                        Text("Draw time:")
                        Text("\((pastDraw.drawTime/1000).format(.dayMonthHoursMinutes))")
                        Spacer()
                        Text("Round:")
                        Text(verbatim: "\(pastDraw.drawId)")
                    }
                    .font(.caption)
                    Divider()
                    FlexibleGridView(items: pastDraw.winningNumbers.list, itemPerRow: 8) { i, number in
                        NumberView(number: number, isSelected: $isSelected, ringColor: ringColors[Int.random(in: 0..<ringColors.count)]) {
                            
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 6)
                    }
                    .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)

                }
                .padding(.bottom, 10)
            }
        }
        .padding()
    }
    
}


#if DEBUG
struct PastDrawResultsView_Previews: PreviewProvider {
    static var previews: some View {
        PastDrawResultsView()
            .environmentObject(Services.shared)
    }
    
}
#endif
