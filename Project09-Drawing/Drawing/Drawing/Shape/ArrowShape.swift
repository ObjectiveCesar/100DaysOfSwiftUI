//
//  ArrowShape.swift
//  Drawing
//
//  Created by Lippmann, Erik on 13.08.22.
//

import SwiftUI

struct ArrowShape: Shape {
    var lineWidth: Double

    var animatableData: Double {
        get { lineWidth }
        set { lineWidth = newValue }
    }

    func path(in rect: CGRect) -> Path {
        let tip = CGPoint(x: rect.midX, y: rect.minY)
        let leftEnd = CGPoint(x: rect.minX, y: rect.midY)
        let rightEnd = CGPoint(x: rect.maxY, y: rect.midY)
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let tail = CGPoint(x: rect.midX, y: rect.maxY)

        var path = Path()
        path.move(to: tip)
        // This is not quite right, but it serves its purpose

        path.addLine(to: leftEnd)
        path.addLine(to: rightEnd)
        path.move(to: CGPoint(x: center.x-lineWidth/2, y: center.y))
        path.addLine(to: CGPoint(x: tail.x-lineWidth/2, y: tail.y))
        path.addLine(to: CGPoint(x: tail.x+lineWidth/2, y: tail.y))
        path.addLine(to: CGPoint(x: center.x+lineWidth/2, y: center.y))

        return path
    }
}
