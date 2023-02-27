//
//  NamingView.swift
//  NameThisPic
//
//  Created by Lippmann, Erik on 23.02.23.
//

import SwiftUI

struct DetailsView: View {

    @State private var displayName: String = ""
    private let image: Image
    private let onSave: (String) -> Void

    @Environment(\.dismiss) private var dismiss

    init(image: Image, onSave: @escaping (String) -> Void) {
        self.image = image
        self.onSave = onSave
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                TextField("Enter a name...", text: $displayName)
                    .font(.body)

                Spacer()
            }
            .padding(.horizontal, 16)
            .navigationTitle("Enter a name")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    onSave(displayName)
                    dismiss()
                } label: {
                    Image(systemName: "tray.and.arrow.down.fill")
                        .tint(.black)
                }
            }
        }
    }
}

struct NamingView_Previews: PreviewProvider {
    static let name = ""
    static var previews: some View {
        DetailsView(image: Image("kevin-horstmann-141705")) { _ in
            // Do nothing.
        }
    }
}
