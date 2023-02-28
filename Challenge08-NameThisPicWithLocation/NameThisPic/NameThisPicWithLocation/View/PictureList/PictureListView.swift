//
//  ContentView.swift
//  NameThisPic
//
//  Created by Lippmann, Erik on 23.02.23.
//

import SwiftUI

struct PictureListView: View {
    @ObservedObject private var viewModel = ViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                if viewModel.pictures.count > 0 {
                    List {
                        ForEach($viewModel.pictures, id: \.name) {
                            let picture = $0.wrappedValue
                            HStack {
                                Text(picture.displayName)
                                Spacer()
                            }
                            .onTapGesture {
                                guard let image = viewModel.loadImage(with: picture.name) else { return }
                                viewModel.tappedImage = image
                                viewModel.tappedImageName = picture.displayName
                                viewModel.tappedImageLocation = picture.location
                            }
                        }
                        .onDelete(perform: deletePictures)
                    }
                    .listStyle(.plain)

                    Text("Hint: Use the \(Image(systemName: "plus.circle.fill")) button to add more pictures.")
                        .foregroundColor(.secondary)

                    Spacer()
                } else {
                    Text("No pictures, yet.")
                        .font(.title)
                    Text("Use the \(Image(systemName: "plus.circle.fill")) button to name your fist picture.")
                }
            }
            .navigationTitle("Name this pic app")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    viewModel.showImagePicker = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
                .tint(.primary)
            }
            .onChange(of: viewModel.selectedImage) { newValue in
                if newValue != nil {
                    viewModel.showNamingSheet = true
                }
            }
            .onChange(of: viewModel.tappedImage, perform: { newValue in
                if newValue != nil {
                    viewModel.showPreview = true
                }
            })
            .sheet(isPresented: $viewModel.showImagePicker) {
                ImagePicker(image: $viewModel.selectedImage)
            }
            .sheet(isPresented: $viewModel.showNamingSheet) {
                viewModel.selectedImage = nil
            } content: {
                DetailsView(image: viewModel.image) {
                    viewModel.saveSelectedImage(name: $0, location: $1)
                }
            }
            .sheet(isPresented: $viewModel.showPreview) {
                viewModel.tappedImage = nil
            } content: {
                if let image = viewModel.tappedImage {
                    PreviewView(image: Image(uiImage: image), name: viewModel.tappedImageName, location: viewModel.tappedImageLocation)
                }
            }
            .onAppear {
                viewModel.fetchSavedPictures()
            }
        }
    }

    private func deletePictures(at offsets: IndexSet) {
        for offset in offsets {
            let picture = viewModel.pictures[offset]
            viewModel.deleteImage(with: picture.name)
        }
    }
}

struct PictureListView_Previews: PreviewProvider {
    static var previews: some View {
        PictureListView()
    }
}
