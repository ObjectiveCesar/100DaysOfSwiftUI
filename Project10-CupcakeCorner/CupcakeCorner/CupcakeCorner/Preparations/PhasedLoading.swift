//
//  PhasedLoading.swift
//  CupcakeCorner
//
//  Created by Lippmann, Erik on 16.10.22.
//

import SwiftUI

struct PhasedLoading: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/bad.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image.")
            } else {
                ProgressView()
            }
        }
    }
}

struct PhasedLoading_Previews: PreviewProvider {
    static var previews: some View {
        PhasedLoading()
    }
}
