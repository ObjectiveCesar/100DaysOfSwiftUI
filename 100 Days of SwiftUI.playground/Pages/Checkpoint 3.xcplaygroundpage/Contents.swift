import Foundation

// FizzBuzz

for i in 1...100 {
    if i % 3 == 0 && i % 5 == 0 {
        print("FizzBuzz")
    } else if i % 3 == 0 {
        print("Fizz")
    } else if i % 5 == 0 {
        print("Buzz")
    } else {
        print("\(i)")
    }
}
print()

var i = 0
while i < 100 {
    i += 1
    switch (i % 3 == 0, i % 5 == 0) {
    case (true, true):
        print("FizzBuzz")
    case (true, false):
        print("Fizz")
    case (false, true):
        print("Buzz")
    default:
        print("\(i)")
    }
}
print()

let range = 1...100
range.forEach { i in
    var message = ""
    if i % 3 == 0 {
        message += "Fizz"
    }
    
    if i % 5 == 0 {
        message += "Buzz"
    }
    
    print(message.isEmpty ? "\(i)" : message)
}
