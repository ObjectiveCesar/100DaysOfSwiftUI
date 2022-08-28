//
//  InsettableShapeView.swift
//  Drawing
//
//  Created by Lippmann, Erik on 13.08.22.
//

import SwiftUI

struct InsettableShapeView: View {
    var body: some View {
        VStack{
            Circle()
                .stroke(.blue, lineWidth: 40)

            Circle()
                .strokeBorder(.blue, lineWidth: 40)

            Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true, inset: 40)
                .strokeBorder(.blue, lineWidth: 40)
        }
    }
}

struct InsettableShapeView_Previews: PreviewProvider {
    static var previews: some View {
        InsettableShapeView()
    }
}
