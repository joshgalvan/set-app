//
//  AdaptableToScrollVGrid.swift
//  Set
//
//  Adapted from CS193P Standford Instructor by Joshua Galvan on 3/24/23.
//

import SwiftUI

// This 'view' allows you to opt a LazyVGrid into being put into a ScrollView once the
// elements have reached a certain minimum width.
struct AdaptableToScrollVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    var items: [Item]
    var aspectRatio: CGFloat
    var minWidth: CGFloat
    var content: (Item) -> ItemView
    
    init(items: [Item], aspectRatio: CGFloat, minWidth: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.minWidth = minWidth
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let width: CGFloat = max(widthThatFits(itemCount: items.count, in: geometry.size, itemAspectRatio: aspectRatio),
                                     CGFloat(minWidth))
            if width == minWidth {
                ScrollView(showsIndicators: false) {
                    VStack {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: width), spacing: 0)], spacing: 0) {
                            ForEach(items) { item in
                                content(item).aspectRatio(aspectRatio, contentMode: .fit)
                            }
                        }
                        Spacer(minLength: 0)
                    }
                }
            } else {
                VStack {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: width), spacing: 0)], spacing: 0) {
                        ForEach(items) { item in
                            content(item).aspectRatio(aspectRatio, contentMode: .fit)
                        }
                    }
                    Spacer(minLength: 0)
                }
            }
        }
    }
    
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            if  CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        } while columnCount < itemCount
        if columnCount > itemCount {
            columnCount = itemCount
        }
        return floor(size.width / CGFloat(columnCount))
    }
}
