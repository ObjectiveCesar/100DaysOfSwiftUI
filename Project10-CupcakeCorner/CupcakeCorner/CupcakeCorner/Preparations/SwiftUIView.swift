//
//  SwiftUIView.swift
//  CupcakeCorner
//
//  Created by Lippmann, Erik on 16.10.22.
//

import SwiftUI

struct SwiftUIView: View {

    @State private var username = ""
    @State private var email = ""

    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                    .textContentType(.username)

                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
            }
            .autocorrectionDisabled()
            .autocapitalization(.none)

            Section {
                Button("Create account") {
                    print("Creating account...")
                }
            }
            .disabled(disableForm)
        }
    }

    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
