import UIKit

let optionalString: String? = "Jimmy"

func sayMyName(_ name: String) -> String {
    return "My name is \(name)"
}

// Without Map
if let unwrappedString = optionalString {
//    print(sayMyName(unwrappedString))
}

// Using Map

//print(optionalString.map({sayMyName($0)}))

// My Map

extension Optional {
    func myMap<U>(_ transform: (Wrapped)->U) -> U?{
        switch self {
        case .some(let value):
            return .some(transform(value))
        case .none:
            return .none
        }
    }
}

//print(optionalString.myMap({sayMyName($0)}))

// How does map apply to array

let arrayOfInts = [2,4,6]
func timesTwo(value: Int) -> Int {
    return value * 2
}

// 1. loop
for value in arrayOfInts {
//    print(timesTwo(value: value))
}

// 2. Map
let doubledArray = arrayOfInts.map({timesTwo(value: $0)})
//doubledArray.forEach({print($0)})

// 3. define the function inside the closure
let functionDefinedInClosureDoubledArray = arrayOfInts.map{$0*2}
//functionDefinedInClosureDoubledArray.forEach({print($0)})

let numbersString = ["1", "2", "Fish"]

let mappedNumbers = numbersString.map{Int($0)}
let flatMappedNumbers = numbersString.flatMap{Int($0)}

//mappedNumbers.forEach({print($0)})
//flatMappedNumbers.forEach({print($0)})



let stringNumber:String? = "5"
let number = stringNumber.flatMap {Int($0)}
print(stringNumber.map {Int($0)})
print(stringNumber.flatMap {Int($0)})
print(type(of: number))

func doubledEven(_ num: Int) -> Int? {
    return num % 2 == 0 ? num * 2 : nil
}

let result1 = Optional(4).map(doubledEven)
let result2 = Optional(4).flatMap(doubledEven)

print(result1)
print(result2)
