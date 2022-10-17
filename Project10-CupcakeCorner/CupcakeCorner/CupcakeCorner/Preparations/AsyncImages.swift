//
//  AsyncImage.swift
//  CupcakeCorner
//
//  Created by Lippmann, Erik on 16.10.22.
//

import SwiftUI

struct AsyncImages: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 200, height: 200)
    }
}

struct AsyncImages_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImages()
    }
}
