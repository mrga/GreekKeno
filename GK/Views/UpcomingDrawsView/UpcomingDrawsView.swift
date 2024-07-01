//
//  UpcomingGamesView.swift
//  GK
//
//  Created by Branislav Mrganic on 28.6.24..
//

import SwiftUI

struct UpcomingDrawsView: View {
    @EnvironmentObject var services: Services
    @State private var viewModel = ViewModel()

    
    var body: some View {
        switch viewModel.state {
        case .idle:
            Color.clear.onAppear() {
                viewModel.loadData(networkConteroller: services.webApi)
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
        case .loaded(let upcomingData):
            content(upcomingData)
        }
    }
    
    private func content(_ data: [DrawData]) -> some View {
        NavigationView {
            VStack(alignment: .leading)  {
                HStack {
                    Image("flag")
                    Text("Greek keno (20/80)")
                        .font(.headline)
                }
                Divider()
                HStack {
                    Text("Draw time:")
                    Spacer()
                    Text("Bet remaining time:")
                }
                .font(.subheadline)
                Divider()
                List(data, id: \.drawId) { draw in
                    GameInfoRow(drawData: draw) {
                        viewModel.loadData(networkConteroller: services.webApi)
                    }
                }
                .listStyle(.plain)
                
            }
            .padding()
        }
    }
    
    
}

#if DEBUG
struct UpcomingDrawsView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingDrawsView()
            .environmentObject(Services.shared)
    }
    
}
#endif
