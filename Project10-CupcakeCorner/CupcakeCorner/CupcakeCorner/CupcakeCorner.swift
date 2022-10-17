//
//  CupcakeCorner.swift
//  CupcakeCorner
//
//  Created by Lippmann, Erik on 17.10.22.
//

import SwiftUI

struct CupcakeCorner: View {
    @StateObject var order = Order()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }

                    Stepper("Number of cakes: \(order.quantitiy)", value: $order.quantitiy, in: 2...20)
                }

                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled.animation())

                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add some sprinkles", isOn: $order.addSprinkles)
                    }
                }

                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery address")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct CupcakeCorner_Previews: PreviewProvider {
    static var previews: some View {
        CupcakeCorner()
    }
}
