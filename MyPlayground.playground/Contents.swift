import UIKit

var pizzaInInches: Int = 10 {
    willSet{
        print(newValue)
    }
    didSet {
        print(oldValue)
    }
}

pizzaInInches=9


var numberOfPeople: Int = 6
let slicesPerPerson: Int = 5

var numberOfSlices: Int {
    get{
  return  pizzaInInches - 4
    }
    
}


var numberOfPizza : Int {
    get {
        let numberOfPeopleFedPerPizza = numberOfSlices / slicesPerPerson
        return numberOfPeople / numberOfPeopleFedPerPizza
    }
    
    set {
        let totalSlices = numberOfSlices * newValue
        numberOfPeople = totalSlices/slicesPerPerson
    }
}
print(numberOfPizza)
