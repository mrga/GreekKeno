//
//  CountdownView.swift
//  GK
//
//  Created by Branislav Mrganic on 29.6.24..
//

import SwiftUI

struct CountdownView: View {
    
    @State private var viewModel = ViewModel()
    

    init(date: Date, onZeroCount: (() -> Void)?) {
        viewModel.date = date
        viewModel.onZeroCount = onZeroCount
    }
        
    var body: some View {

        // TODO: find better way to this
        // when timeLeftInSeconds is higher then 1h for some strange reason formather add 1 additional hour... swift bug?
        //        Text(viewModel.timeLeftInSeconds >= 3600 ?  viewModel.timeLeftInSeconds.format(.hoursMinutesSeconds) : viewModel.timeLeftInSeconds.format(.minutesSeconds))
        Text(
            viewModel.timeLeftInSeconds >= 3600 ?
            ("\(Int(viewModel.timeLeftInSeconds)/3600):\(viewModel.timeLeftInSeconds.format(.minutesSeconds))")
            : viewModel.timeLeftInSeconds.format(.minutesSeconds)
        )
        .foregroundColor(viewModel.timeLeftInSeconds <= 40 ? .red : Color(UIColor.label))
    }
}

#Preview {
    CountdownView(date: Date(timeIntervalSince1970: 1719656700000/1000)) {
        
    }
}
