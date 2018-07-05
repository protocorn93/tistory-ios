import UIKit

func doNotingButReturn(_ variable: String?) -> String? {
    return variable
}

extension Optional {
    func myMap<U>(_ transform: (Wrapped)->U) -> U? {
        switch self {
        case .some(let value):
            return transform(value)
        case .none:
            return .none
        }
    }
    
    func myFlatMap<U>(_ transform: (Wrapped)->U?) -> U?{
        switch self {
        case .some(let value):
            return transform(value)
        case .none:
            return .none
        }
    }
}

/* myMap & myFlatMap
print(type(of: Optional("3").myMap{Int($0)})) // U == Int? , U? == Int??
print(type(of: Optional("3").myFlatMap{Int($0)})) // U? == Int?, U? == Int?
*/

/*
print(Optional(3).myMap(half))
print(Optional(20).myFlatMap(half))
*/

let stringNumbers:[String] = ["1", "2", "Fish"]
let mappedNumbers = stringNumbers.map {Int($0)}
let flatMappedNumbers = stringNumbers.compactMap {Int($0)}

let optionalStringArray:[String?] = ["1", "2", nil, "3"]

let mappedOptionalStringArray = optionalStringArray.map(doNotingButReturn)
let compactMappedOptionalStringArray = optionalStringArray.compactMap(doNotingButReturn)

extension Array {
    func myMap<T>(_ transform: (Element)-> T?)->[T?]{
        var result:[T?] = []
        self.forEach { (element) in
            result.append(transform(element))
        }
        return result
    }
    
    func myCompactMap<T>(_ transform: (Element) -> T?) -> [T] {
        return myMap(transform).filter { $0 != nil }.map { $0! }
    }
}

let myMappedOptionalStringArray = optionalStringArray.myMap(doNotingButReturn)
let myCompactMappedOptionalStringArray = optionalStringArray.myCompactMap(doNotingButReturn)
let myMappedNumbers = stringNumbers.myMap {Int($0)}
let myCompactMappedNumbers = stringNumbers.myCompactMap {Int($0)}

func half(a: Int) -> Int? {
    return a % 2 == 0 ? a / 2 : .none
}

let value = Optional(20).flatMap(half).flatMap(half).flatMap(half)
