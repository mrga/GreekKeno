//
//  NumberView.swift
//  GK
//
//  Created by Branislav Mrganic on 29.6.24..
//

import SwiftUI

struct NumberView: View {
    let number: Int
    let ringColor: Color
    private let onTapAction: () -> Void
    @State private var radius: CGFloat = .zero
    @Binding private var isSelected: Bool

    
    init(number: Int, isSelected: Binding<Bool>, ringColor: Color,
         onTapAction: @escaping () -> Void) {
        self.number = number
        self.ringColor = ringColor
        self._isSelected = isSelected
        self.onTapAction = onTapAction
    }
    
    var body: some View {
         ZStack {
            Text(number.formatted())
                 .onTapGesture {
                     isSelected.toggle()
                     onTapAction()
                 }
                .padding(.vertical, 3)
                .padding(.vertical, 3)
                .background(GeometryReader { proxy in Color.clear.onAppear() { 
                    radius = max(proxy.size.width, proxy.size.height) } }.hidden())
                    if (!radius.isZero) {
                        Circle()
                            .strokeBorder(ringColor, lineWidth: 2)
                            .opacity(isSelected ? 1 : 0)
                            .frame(width: radius, height: radius)
                    }

            }
    }
}



#if DEBUG

struct NumberView_Previews : PreviewProvider {
    @State  static var isSelected = false

    static var previews: some View {
        NumberView(number: 15, isSelected: $isSelected, ringColor: Color.blue, onTapAction:{
            isSelected = !isSelected
        })
    }

}
#endif
