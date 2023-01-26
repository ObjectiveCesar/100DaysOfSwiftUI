//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Lippmann, Erik on 18.01.23.
//

import SwiftUI

class ImageSaverPrep: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}
