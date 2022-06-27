import Cocoa

protocol Building {
    var rooms: Int { get }
    var costs: Int { get }
    var agent: String { get }
    
    func summary()
}

struct House: Building {
    var rooms: Int
    var costs: Int
    var agent: String
}

struct Office: Building {
    var rooms: Int
    var costs: Int
    var agent: String
}

extension Building {
    func summary() {
        print("\(agent) sold a house with \(rooms) rooms for $\(costs).")
    }
}

let house = House(rooms: 40, costs: 2_500_000, agent: "James Earl Jones")
let office = Office(rooms: 100, costs: 15_000_000, agent: "Donald Trump")

let buildings: [Building] = [house, office]
for building in buildings {
    building.summary()
}
