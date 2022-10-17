//
//  AsyncImage.swift
//  CupcakeCorner
//
//  Created by Lippmann, Erik on 16.10.22.
//

import SwiftUI

struct AsyncImageView: View {
    var body: some View {
        AsyncImage(url: URL(string: "")) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            Color.red
        }

    }
}

struct AsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView()
    }
}
