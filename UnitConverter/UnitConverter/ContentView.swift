//
//  ContentView.swift
//  UnitConverter
//
//  Created by Lippmann, Erik on 27.06.22.
//

import SwiftUI

enum Converter: CaseIterable {
    case temperature
    case length
    case time
    case volume

    var name: String {
        switch self {
        case .temperature: return "Temperature"
        case .length: return "Length"
        case .time: return "Time"
        case .volume: return "Volume"
        }
    }

    var selectableUnits: [(name: String, unit: Dimension)] {
        switch self {
        case .temperature:
            return [("Celsius", UnitTemperature.celsius),
                    ("Fahrenheit", UnitTemperature.fahrenheit),
                    ("Kelvin", UnitTemperature.kelvin)]
        case .length:
            return [("Meters", UnitLength.meters),
                    ("Kilometers", UnitLength.kilometers),
                    ("Feet", UnitLength.feet),
                    ("Yards", UnitLength.yards),
                    ("Miles", UnitLength.miles)]
        case .time:
            return [("Seconds", UnitDuration.seconds),
                    ("Minutes", UnitDuration.minutes),
                    ("Hours", UnitDuration.hours)]
        case .volume:
            return [("Milliliters", UnitVolume.milliliters),
                    ("Liters", UnitVolume.liters),
                    ("Cups", UnitVolume.cups),
                    ("Gallons", UnitVolume.gallons)]
        }
    }

    func convert(_ input: Double, from source: Dimension, to destination: Dimension) -> Double {
        let sourceMeasurement = Measurement(value: input, unit: source)
        return sourceMeasurement.converted(to: destination).value
    }
}

struct ContentView: View {

    @State private var selectedConverter: Converter = .temperature
    @State private var selectedSource: Dimension = UnitTemperature.celsius
    @State private var selectedDestination: Dimension = UnitTemperature.celsius

    @State private var input: Double = 0.0
    @FocusState private var valueIsFocused: Bool

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Units", selection: $selectedConverter) {
                        ForEach(Converter.allCases, id: \.self) {
                            Text($0.name)
                        }
                    }
                    .onChange(of: selectedConverter) {
                        selectedSource = $0.selectableUnits.first!.unit
                        selectedDestination = selectedSource
                    }
                    .pickerStyle(.automatic)
                } header: {
                    Text("Choose a converter")
                }

                Section {
                    Picker("Source", selection: $selectedSource) {
                        ForEach(selectedConverter.selectableUnits, id:\.self.unit) {
                            Text($0.name)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert from")
                }

                Section {
                    Picker("Destination", selection: $selectedDestination) {
                        ForEach(selectedConverter.selectableUnits, id: \.self.unit) {
                            Text($0.name)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert to")
                }

                Section {
                    TextField("Enter a value", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($valueIsFocused)
                } header: {
                    Text("Source Value")
                }

                Section {
                    let converter = selectedConverter
                    let value = converter.convert(input,
                                                  from: selectedSource,
                                                  to: selectedDestination)
                    Text("\(value.formatted())")
                } header: {
                    Text("Converted Value")
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        valueIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
