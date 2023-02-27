//
//  PreviewView.swift
//  NameThisPic
//
//  Created by Lippmann, Erik on 27.02.23.
//

import SwiftUI

struct PreviewView: View {

    @Environment(\.dismiss) private var dismiss

    let image: Image
    let name: String

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
            }
            .padding(.horizontal, 16)
            .navigationTitle(name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .tint(.black)
                }
            }
        }
    }
}

struct PreviewView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView(image: Image("kevin-horstmann-141705"), name: "Flowers")
    }
}
