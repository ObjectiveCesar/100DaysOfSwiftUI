import Cocoa

enum SquareRootError: Error {
    case outOfBounce
    case noRoot
}

func squareRoot(of number: Int, in range: ClosedRange<Int> = 1...10_000) throws -> Int {
    if !range.contains(number) { throw SquareRootError.outOfBounce }
    for i in 1...number {
        if i * i == number { return i }
    }
    
    throw SquareRootError.noRoot
}

for i in 0...10001 {
    do {
        let result = try squareRoot(of: i)
        print("The square root of \(i) is \(result).")
    } catch SquareRootError.outOfBounce {
        print("\(i) is out of bounce.")
    } catch SquareRootError.noRoot {
        print("There is no integer square root for \(i).")
    } catch {
        print("An unknown error occured. \(error)")
    }
}
