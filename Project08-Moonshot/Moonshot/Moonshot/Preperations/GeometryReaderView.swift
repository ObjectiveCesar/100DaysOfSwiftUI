//
//  ContentView.swift
//  Moonshot
//
//  Created by Lippmann, Erik on 05.08.22.
//

import SwiftUI

struct GeometryReaderView: View {
    var body: some View {
        GeometryReader { geo in
            Image("aldrin")
                .resizable()
                .scaledToFit()
                .frame(width: geo.size.width * 0.8)
                .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

struct GeometryReaderView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderView()
    }
}
