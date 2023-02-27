//
//  ContentView.swift
//  A11y
//
//  Created by Lippmann, Erik on 22.02.23.
//

import SwiftUI

struct A11yLabelsView: View {
    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]

    @State private var selectedPicture = Int.random(in: 0...3)

    var body: some View {
        Image(pictures[selectedPicture])
            .resizable()
            .scaledToFit()
            .onTapGesture {
                selectedPicture = Int.random(in: 0...3)
            }
    }
}

struct A11yLabelsView_Previews: PreviewProvider {
    static var previews: some View {
        A11yLabelsView()
    }
}
