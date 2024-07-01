//
//  UpcomingDrawsView+ViewModel.swift
//  GK
//
//  Created by Branislav Mrganic on 29.6.24..
//

import Foundation

extension UpcomingDrawsView {
    
    @Observable
    class ViewModel {
        
        var drawData: DrawData?
        
        enum State {
            case idle
            case loading
            case failed(String)
            case loaded([DrawData])
        }
        
        var state = State.idle
        var showingAlert = false
        
        func loadData(networkConteroller: NetworkControllable) {
            
            state = .loading
                        
            networkConteroller.loadUpcamingDrawData(gameId: 1100, upcoming: 20, completion: {  [weak self] result in
                switch result {
                case .success(let upcomingDraws):
                    self?.state = .loaded(upcomingDraws)
                case .failure(let error):
                    self?.state = .failed(error.localizedDescription)
                    self?.showingAlert = true
                }
            })
        }
    
    }
}
