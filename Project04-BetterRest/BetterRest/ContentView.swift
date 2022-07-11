//
//  ContentView.swift
//  BetterRest
//
//  Created by Lippmann, Erik on 08.07.22.
//

import CoreML
import SwiftUI

struct ContentView: View {

    @State private var sleepHours = 8
    @State private var sleepMinutes = 0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1

    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }

    init(){
        UITableView.appearance().backgroundColor = .clear
    }

    var body: some View {
        NavigationView {
            Form {
                Section("When do you want to wake up?") {
                    DatePicker("Choose a time",
                               selection: $wakeUp,
                               displayedComponents: .hourAndMinute)
                    .labelsHidden()
                }

                Section("Desired amount of sleep") {
                    VStack(spacing: 8) {
                        Picker("Hours", selection: $sleepHours) {
                            ForEach(4...12, id: \.self) { amount in
                                Text("\(amount)")
                            }
                        }
                        .pickerStyle(.automatic)

                        Picker("Minutes", selection: $sleepMinutes) {
                            ForEach(0...45, id: \.self) { amount in
                                if amount == 0 || amount % 15 == 0 {
                                    Text("\(amount)")
                                }
                            }
                        }
                        .pickerStyle(.automatic)
                    }
                }

                Section("Daily coffee intake") {
                    Stepper("\(coffeeAmount) " + (coffeeAmount == 1 ? "cup" : "cups"),
                            value: $coffeeAmount, in: 1...20)
                }

                Section("Recommended bedtime") {
                    Text(calculateBedtime())
                        .font(.largeTitle)
                }
            }
            .navigationTitle("BetterRest")
        }
    }

    func calculateBedtime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hourInSeconds = (components.hour ?? 0) * 60 * 60
            let minuteInSeconds = (components.minute ?? 0) * 60

            let prediction = try model.prediction(wake: Double(hourInSeconds + minuteInSeconds),
                                                  estimatedSleep: Double(sleepHours*60 + sleepMinutes) / 60,
                                                  coffee: Double(coffeeAmount))

            let sleepTime = wakeUp - prediction.actualSleep
            return sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return "Sorry, could not calculate."
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
