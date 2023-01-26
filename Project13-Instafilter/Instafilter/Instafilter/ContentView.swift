//
//  ContentView.swift
//  Instafilter
//
//  Created by Lippmann, Erik on 09.01.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section("Preparations") {
                    NavigationLink("Property Wrapper") {
                        PropertyWrapperView()
                    }

                    NavigationLink("OnChange Modifier") {
                        OnChangeView()
                    }

                    NavigationLink("Confirmation Dialog") {
                        ConfirmationDialogView()
                    }

                    NavigationLink("CoreImage") {
                        CoreImageView()
                    }

                    NavigationLink("ImagePicker") {
                        ImagePickerView()
                    }
                }

                Section("Project") {
                    NavigationLink("Instafilter") {
                        Instafilter()
                    }

                }
            }
            .navigationTitle("Project 13")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
