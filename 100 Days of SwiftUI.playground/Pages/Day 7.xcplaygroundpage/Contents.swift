import Cocoa

func containSameLetters(string1: String, string2: String) -> Bool {
    string1.lowercased().sorted() == string2.lowercased().sorted()
}

let doThey = containSameLetters(string1: "ABC", string2: "cba")
print("\(doThey)")


func pythagoras(a: Double, b: Double) -> Double {
    sqrt(a * a + b * b)
}

let c = pythagoras(a: 3, b: 4)
print(c)
