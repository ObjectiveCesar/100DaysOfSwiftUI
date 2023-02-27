//
//  HidingAndGroupingView.swift
//  A11y
//
//  Created by Lippmann, Erik on 22.02.23.
//

import SwiftUI

struct HidingAndGroupingView: View {
    var body: some View {
        ScrollView {
            VStack {
                Image(decorative: "ales-krivec-15949")
                Image("galina-n-189483")
                    .accessibilityHidden(true)

                VStack {
                    Text("A11y element children are...")
                    Text("... combined.")
                        .font(.title)
                }
                .accessibilityElement(children: .combine)

                VStack {
                    Text("A11y element children are...")
                    Text("... ignored.")
                        .font(.title)
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("A11y element children are ignored.")
            }
        }
    }
}

struct HidingAndGroupingView_Previews: PreviewProvider {
    static var previews: some View {
        HidingAndGroupingView()
    }
}
