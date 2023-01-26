//
//  CoreImageView.swift
//  Instafilter
//
//  Created by Lippmann, Erik on 09.01.23.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct CoreImageView: View {
    @State private var image: Image?

    var body: some View {
        List {
            NavigationLink("SwiftUI") {
                SwifUIImageView()
            }

            NavigationLink("Core Image") {
                CoreImageImageView()
            }
        }
    }

}

struct SwifUIImageView: View {
    @State private var image: Image?

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }

    func loadImage() {
        image = Image("3Falls_Niagara")
    }
}

struct CoreImageImageView: View {
    @State private var image: Image?

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            HStack {
                Button(action: sepia) {
                    Text("Sepia")
                        .foregroundColor(.white)
                        .padding()
                        .background(.brown)
                        .clipShape(
                            RoundedRectangle( cornerRadius: 4)
                        )

                }

                Button(action: pixelate) {
                    Text("Pixaelate")
                        .foregroundColor(.white)
                        .padding()
                        .background(.blue)
                        .clipShape(
                            RoundedRectangle( cornerRadius: 4)
                        )
                }

                Button(action: crystallyze) {
                    Text("Crystallyze")
                        .foregroundColor(.white)
                        .padding()
                        .background(.green)
                        .clipShape(
                            RoundedRectangle( cornerRadius: 4)
                        )
                }

                Button(action: twirl) {
                    Text("Twirl")
                        .foregroundColor(.white)
                        .padding()
                        .background(.red)
                        .clipShape(
                            RoundedRectangle( cornerRadius: 4)
                        )
                }
            }
        }
        .onAppear(perform: sepia)
    }

    func twirl() {
        guard let inputImage = UIImage(named: "3Falls_Niagara") else { return }
        let beginImage = CIImage(image: inputImage)

        let context = CIContext()
        let currentFilter = CIFilter.twirlDistortion()
        currentFilter.inputImage = beginImage

        let amount = 1.0

        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey) }

        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return }

        // attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            let uiImage = UIImage(cgImage: cgimg)

            // and convert that to a SwiftUI image
            image = Image(uiImage: uiImage)
        }
    }

    func crystallyze() {
        guard let inputImage = UIImage(named: "3Falls_Niagara") else { return }
        let beginImage = CIImage(image: inputImage)

        let context = CIContext()
        let currentFilter = CIFilter.crystallize()
        currentFilter.inputImage = beginImage
        currentFilter.radius = 200

        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return }

        // attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            let uiImage = UIImage(cgImage: cgimg)

            // and convert that to a SwiftUI image
            image = Image(uiImage: uiImage)
        }
    }

    func pixelate() {
        guard let inputImage = UIImage(named: "3Falls_Niagara") else { return }
        let beginImage = CIImage(image: inputImage)

        let context = CIContext()
        let currentFilter = CIFilter.pixellate()
        currentFilter.inputImage = beginImage
        currentFilter.scale = 100

        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return }

        // attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            let uiImage = UIImage(cgImage: cgimg)

            // and convert that to a SwiftUI image
            image = Image(uiImage: uiImage)
        }
    }

    func sepia() {
        guard let inputImage = UIImage(named: "3Falls_Niagara") else { return }
        let beginImage = CIImage(image: inputImage)

        let context = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        currentFilter.inputImage = beginImage
        currentFilter.intensity = 1

        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return }

        // attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            let uiImage = UIImage(cgImage: cgimg)

            // and convert that to a SwiftUI image
            image = Image(uiImage: uiImage)
        }
    }
}

struct CoreImageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CoreImageView()
        }
    }
}
