//
//  Instafilter.swift
//  Instafilter
//
//  Created by Lippmann, Erik on 18.01.23.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct Instafilter: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 200.0
    @State private var filterScale = 10.0

    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    @State private var showingFilterSheet = false

    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()

    @State private var processedImage: UIImage?

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)

                    if image == nil {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }

                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }

                if currentFilter.inputKeys.contains(kCIInputIntensityKey) {
                    SliderView(title: "Intensity",
                               value: $filterIntensity,
                               key: kCIInputIntensityKey,
                               range: 0...1,
                               onValueChange: applyProcessing(value:for:))
                }

                if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
                    SliderView(title: "Radius",
                               value: $filterRadius,
                               key: kCIInputRadiusKey,
                               range: 1...1000,
                               onValueChange: applyProcessing(value:for:))
                }

                if currentFilter.inputKeys.contains(kCIInputScaleKey) {
                    SliderView(title: "Scale",
                               value: $filterScale,
                               key: kCIInputScaleKey,
                               range:1...100,
                               onValueChange: applyProcessing(value:for:))
                }

                HStack {
                    Button("Change Filter") {
                        showingFilterSheet = true
                    }
                    .disabled(image == nil)

                    Spacer()

                    Button("Save", action: save)
                        .disabled(image == nil)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Twirl") { setFilter(CIFilter.twirlDistortion()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }

        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing(value: filterIntensity, for: kCIInputIntensityKey)
        applyProcessing(value: filterRadius, for: kCIInputRadiusKey)
        applyProcessing(value: filterScale, for: kCIInputScaleKey)
    }

    func applyProcessing(value: Double, for key: String) {
        guard currentFilter.inputKeys.contains(key) else { return }
        currentFilter.setValue(value, forKey: key)

        guard let outputImage = currentFilter.outputImage else { return }

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }

    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }

    func save() {
        guard let processedImage = processedImage else { return }

        let imageSaver = ImageSaver()
        imageSaver.successHandler = {
            print("Success!")
        }
        imageSaver.errorHandler = {
            print("Oops: \($0.localizedDescription)")
        }
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
}

struct SliderView: View {
    let title: String
    @Binding var value: Double
    let key: String
    let range: ClosedRange<Double>
    let onValueChange: (_ value: Double, _ key: String) -> Void

    var body: some View {
        HStack {
            Text(title)
            Slider(value: $value, in: range)
                .onChange(of: value) { _ in
                    onValueChange(value, key)
                }
        }
        .padding(.vertical)
    }
}

struct Instafilter_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Instafilter()
        }
    }
}
