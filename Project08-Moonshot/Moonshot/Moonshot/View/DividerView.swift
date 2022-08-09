//
//  DividerView.swift
//  Moonshot
//
//  Created by Lippmann, Erik on 08.08.22.
//

import SwiftUI

struct DividerView: View {
    let color: Color

    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(color)
            .padding(.vertical)
    }
}

struct DividerView_Previews: PreviewProvider {
    static var previews: some View {
        DividerView(color: .lightBackground)
            .preferredColorScheme(.dark)
    }
}
