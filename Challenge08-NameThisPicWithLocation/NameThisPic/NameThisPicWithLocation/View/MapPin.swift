//
//  MapPin.swift
//  NameThisPicWithLocation
//
//  Created by Lippmann, Erik on 28.02.23.
//

import SwiftUI

struct MapPin: View {
    var body: some View {
        Image(systemName: "mappin.and.ellipse")
            .resizable()
            .foregroundColor(.red)
            .frame(width: 24, height: 24)
    }
}

struct MapPin_Previews: PreviewProvider {
    static var previews: some View {
        MapPin()
    }
}
