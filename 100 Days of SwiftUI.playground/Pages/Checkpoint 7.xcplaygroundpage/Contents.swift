import Cocoa

class Animal {
    var legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    var type: String
    
    init(type: String) {
        self.type = type
        super.init(legs: 4)
    }
    
    func speak() {
        print("I am animal that barks.")
    }
}

class Corgi: Dog {
    
    init() {
        super.init(type: "Corgi")
    }
    
    override func speak() {
        print("Wuff!")
    }
}

class Poodle: Dog {
    
    init() {
        super.init(type: "Poodle")
    }
    
    override func speak() {
        print("Rrrrraffff!")
    }
}

class Cat: Animal {
    var type: String
    var isTame: Bool
 
    init(type: String, isTame: Bool) {
        self.type = type
        self.isTame = isTame
        super.init(legs: 4)
    }
    
    func speak() {
        print("I am animal that does not bark.")
    }
    
    func shouldYouTouchMe() {
        print(isTame ? "Touch me if you want." : "Better don’t touch!")
    }
}

class Persian: Cat {
    
    init() {
        super.init(type: "Persinal", isTame: true)
    }
    
    override func speak() {
        print("Miaaahahhhuou")
    }
}

class Lion: Cat {
    init() {
        super.init(type: "Lion", isTame: false)
    }
    
    override func speak() {
        print("Rooooowl!")
    }
}

let corgi = Corgi()
let poodle = Poodle()
let persian = Persian()
let lion = Lion()

print("I am a \(corgi.type) and I make:")
corgi.speak()
print("I am a \(poodle.type) and I make:")
poodle.speak()
print("I am a \(persian.type) and I make:")
persian.speak()
persian.shouldYouTouchMe()
print("I am a \(lion.type) and I make:")
lion.speak()
lion.shouldYouTouchMe()


