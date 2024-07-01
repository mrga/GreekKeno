//
//  TalonView+ViewModel.swift
//  GK
//
//  Created by Branislav Mrganic on 29.6.24..
//

import SwiftUI

extension TalonView {
    @Observable
    class ViewModel {
        
        enum State {
            case loading
            case failed(String)
            case loaded(DrawData)
        }
        
        var networkConteroller: NetworkControllable?
        var drawData: DrawData? {
            didSet {
                guard  let drawData = drawData else {
                   return
                }
                state = State.loaded(drawData)
            }
        }
        var selectedNumbers: [Int] = []
        
        var ringColors: [Color]
        { 
            return [Color.lottoYellow,
                    Color.orange,
                    Color.lottoRed,
                    Color.lottoPink,
                    Color.lottoPurple,
                    Color.lottoLightBlue,
                    Color.lottoGreen,
                    Color.lottoBlue,
                    Color.lottoGray]
        }
         
        var odds: [Double] {
            return [3.37, 14, 65, 275, 1350, 6500, 25000, 125000]
        }
        
                
        init() {
            self.networkConteroller = Services.shared.webApi
        }
        
   
        
        var state = State.loading
        var showingAlert = false
        
//        func loadData() {
//            
//            state = .loading
//                    
//            networkConteroller?.loadUpcamingDrawData(gameId: 1100, upcoming: 20, completion: {  [weak self] result in
//                switch result {
//                case .success(let data):
//                    guard let drawData = data.first else {
//                        self?.state = .failed("Unable to load draw data")
//                        self?.showingAlert = true
//                        return
//                    }
//                    self?.state = .loaded(drawData)
//                case .failure(let error):
//                    self?.state = .failed(error.localizedDescription)
//                    self?.showingAlert = true
//                }
//            })
//        }
    
    }
}
