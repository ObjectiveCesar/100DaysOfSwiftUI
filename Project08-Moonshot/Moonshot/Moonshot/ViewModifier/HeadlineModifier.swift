//
//  HeadlineModifiert.swift
//  Moonshot
//
//  Created by Lippmann, Erik on 09.08.22.
//

import SwiftUI

struct HeadlineModifier: ViewModifier {
    let title: String

    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .background(.darkBackground)
            .preferredColorScheme(.dark)
    }

}

extension View {
    func asHeadline(_ title: String) -> some View {
        modifier(HeadlineModifier(title: title))
    }
}
