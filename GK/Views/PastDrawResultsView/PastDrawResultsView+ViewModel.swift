//
//  PastDrawResultsView+ViewModel.swift
//  GK
//
//  Created by Branislav Mrganic on 29.6.24..
//

import SwiftUI

extension PastDrawResultsView {
    
    
    @Observable
    class ViewModel {
            
        enum State {
               case idle
               case loading
               case failed(String)
               case loaded(PastDraws)
           }
        
        var state = State.idle
        var showingAlert = false
        
        func load(networkConteroller: NetworkControllable) {
            state = .loading
            
            // show yesterdays results
            let noon = Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date.now)!
            let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: noon)?.timeIntervalSince1970
            guard let date = yesterday?.format(.dateShort) else  {
                state = .failed("Spmething went wrong")
                return
            }
            
            networkConteroller.loadPastDrwas(gameid: 1100, from: date, to: date, completion: { [weak self] result in
                switch result {
                case .success(let pastDraws):
                    self?.state = .loaded(pastDraws)
                case .failure(let error):
                    self?.state = .failed(error.localizedDescription)
                    self?.showingAlert = true
                }
            })
        }
    }
}
