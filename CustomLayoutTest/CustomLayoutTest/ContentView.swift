//
//  ContentView.swift
//  CustomLayoutTest
//
//  Created by Michael Novosad on 26.12.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        BackslashStack {
            Text("1")
                .frame(width: 50)
                .border(.yellow)
            Text("2")
                .frame(width: 100)
                .border(.blue)
            Text("3")
                .frame(width: 200)
                .border(.green)
        }
        .border(.pink)
        .font(.title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BackslashStack: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let subviewSizes = subviews.map { proxy in
            return proxy.sizeThatFits(.unspecified)
        }

        let combinedSize = subviewSizes.reduce(.zero) { currentSize, subviewSize in
            return CGSize(
                width: currentSize.width + subviewSize.width,
                height: currentSize.height + subviewSize.height)
        }

        return combinedSize
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let subviewSizes = subviews.map { proxy in
            return proxy.sizeThatFits(.unspecified)
        }

        var x = bounds.minX
        var y = bounds.minY

        for index in subviews.indices {
            let subviewSize = subviewSizes[index]
            let sizeProposal = ProposedViewSize(
                width: subviewSize.width,
                height: subviewSize.height)

            subviews[index]
                .place(
                    at: CGPoint(x: x, y: y),
                    anchor: .topLeading,
                    proposal: sizeProposal)

            x += subviewSize.width
            y += subviewSize.height
        }
    }


}
