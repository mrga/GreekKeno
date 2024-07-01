//
//  FlexibleGridView.swift
//  GK
//
//  Created by Branislav Mrganic on 29.6.24..
//

import SwiftUI

struct FlexibleGridView<Content: View>: View {
    
    let content: (Int, Int) -> Content
    let items: [Int]
    let itemsPerRow: Int
    let numberOfRow: Int
    
    
    init(items: [Int], itemPerRow: Int, @ViewBuilder content: @escaping (Int,Int) -> Content) {
        self.items = items
        self.itemsPerRow = itemPerRow
        self.content = content
        self.numberOfRow = items.count / itemsPerRow + (items.count % itemsPerRow != 0 ? 1 : 0)
        
    }
    
    
    var body: some View {
        VStack {

            Grid(horizontalSpacing: -1, verticalSpacing: -1) {
                ForEach(0..<numberOfRow, id: \.self) { row in
                    let start = row * itemsPerRow
                    let end = (start + itemsPerRow <= items.count)  ? (start + itemsPerRow) : (start + items.count % itemsPerRow)
                    
                    GridRow {
                        ForEach(start..<end, id: \.self) { index  in
                            content(index, items[index])
                        }
                    }
                }
            }
            
        }
    }
    
}



#if DEBUG

struct FlexibleGridView_Previews : PreviewProvider {
    @State  static var isSelected = true

    static var previews: some View {
        FlexibleGridView(items: Array(1...80), itemPerRow: 8) { i, _ in
            NumberView(number: i, isSelected: $isSelected, ringColor: Color.yellow) {
                
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 6)
            .border(Color.red)
        }
    }

}
#endif
