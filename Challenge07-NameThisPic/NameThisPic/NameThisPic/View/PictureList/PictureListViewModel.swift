//
//  PictureListViewModel.swift
//  NameThisPic
//
//  Created by Lippmann, Erik on 23.02.23.
//

import Foundation
import Photos
import SwiftUI
import UIKit

extension PictureListView {

    enum DataError: Error {
        case savingError
    }

    private static let directory = "pictures"

    @MainActor
    class ViewModel: ObservableObject {
        @Published var pictures: [NamedPicture] = []
        @Published var showNamingSheet = false
        @Published var showImagePicker = false
        @Published var selectedImage: UIImage?
        @Published var tappedImage: UIImage?
        @Published var tappedImageName: String = ""
        @Published var showPreview = false

        let jsonPath = FileManager.documentsDirectory.appendingPathComponent("SavedPictures.json")

        var image: Image {
            if let image = selectedImage {
                return Image(uiImage: image)
            } else {
                return Image("photo")
            }
        }

        func fetchSavedPictures() {
            do {
                let data = try Data(contentsOf: jsonPath)
                pictures = try JSONDecoder().decode([NamedPicture].self, from: data)
            } catch {
                pictures = []
            }
        }

        func saveSelectedImage(name: String) {
            let saveName = UUID().uuidString
            let picture = NamedPicture(name:saveName, displayName: name)
            pictures.append(picture)
            saveJson()
            savePicture(picture)
        }

        func loadImage(with name: String) -> UIImage? {
            do {
                guard let url = URL(string: filePath(named: name)) else { return nil }
                let jpegData = try Data(contentsOf: url)
                let image = UIImage(data: jpegData) 
                return image
            } catch {
                return nil
            }
        }

        func deleteImage(with name: String) {
            do {
                guard let url = URL(string: filePath(named: name)) else { return }
                try FileManager.default.removeItem(at: url)
                pictures.removeAll { $0.name == name }
                saveJson()
            } catch {
                print("Unable to delete data.")
            }
        }

        private func filePath(named: String) -> String {
            FileManager.documentsDirectory.appendingPathComponent("\(named).jpg").absoluteString
        }

        private func savePicture(_ picture: NamedPicture) {
            do {
                if let jpegData = selectedImage?.jpegData(compressionQuality: 0.8) {
                    let url = FileManager.documentsDirectory.appendingPathComponent("\(picture.name).jpg")
                    try jpegData.write(to: url, options: [.atomic, .completeFileProtection])
                } else {
                    throw DataError.savingError
                }
            } catch {
                print("Unable to save picture data.")
            }
        }

        private func saveJson() {
            do {
                let data = try JSONEncoder().encode(pictures)
                try data.write(to: jsonPath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save json data.")
            }
        }
    }
}
