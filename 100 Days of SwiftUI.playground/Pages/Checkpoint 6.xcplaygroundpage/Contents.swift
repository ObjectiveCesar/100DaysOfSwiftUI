import Foundation

struct Car {
    
    enum ShiftDirection {
        case up
        case down
    }
    
    static let seatsRange = 1...8
    static let gearsRange = 1...8
    
    let model: String
    private var seats: Int = 5
    private var gears: Int = 6
    private(set) var currentGear = 1 {
        didSet {
            print("Shifting from gear \(oldValue) to gear \(currentGear)")
        }
    }
    
    init(model: String, seats: Int, gears: Int) {
        self.model = model
        
        switch gears {
        case ..<Car.gearsRange.lowerBound:
            print("No gears for \(model)? Setting to gears \(self.gears).")
        case (Car.gearsRange.upperBound+1)...:
            print("Is \(model) a truck? Setting gears to \(self.gears).")
        default:
            self.gears = gears
        }
        
        switch seats {
        case ..<Car.seatsRange.lowerBound:
            print("No seats for \(model)? Setting seats to \(self.seats).")
        case (Car.seatsRange.upperBound+1)...:
            print("Is \(model)a bus? Setting seats to \(self.seats).")
        default:
            self.seats = seats
        }
    }
    
    mutating func shift(_ direction: ShiftDirection) {
        switch direction {
        case .up:
            if Car.gearsRange.contains(currentGear + 1) {
                currentGear += 1
                return
            }
        case .down:
            if Car.gearsRange.contains(currentGear - 1) {
                currentGear -= 1
                return
            }
        }
        
        print("You’re out of gears, bro!")
    }
}

var ferrari = Car(model: "Ferrari F50", seats: 2, gears: 8)
ferrari.shift(.up)
ferrari.shift(.up)
ferrari.shift(.up)
ferrari.shift(.up)
ferrari.shift(.up)
ferrari.shift(.up)
ferrari.shift(.up)
ferrari.shift(.up)
var multipla = Car(model: "Fiat Miltipla", seats: 7, gears: 7)
var multivan = Car(model: "VW Multivan", seats: 8, gears: 6)
var bus = Car(model: "Greyhound", seats: 88, gears: 12)

