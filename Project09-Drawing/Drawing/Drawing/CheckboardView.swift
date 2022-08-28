//
//  CheckboardView.swift
//  Drawing
//
//  Created by Lippmann, Erik on 13.08.22.
//

import SwiftUI

struct CheckboardView: View {
    @State private var rows = 4
    @State private var columns = 4

    var body: some View {
        Checkerboard(rows: rows, columns: columns)
            .frame(width: 400, height: 400)
            .onTapGesture {
                withAnimation(.linear(duration: 3)) {
                    let value = 16
                    rows = value
                    columns = value
                }
            }
    }
}

struct CheckboardView_Previews: PreviewProvider {
    static var previews: some View {
        CheckboardView()
    }
}
