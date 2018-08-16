//: Playground - noun: a place where people can play

import Cocoa
/*
 .caseInsensitive : both uppercase and lowecase
*/
let stringPattern = "^\"(?!.*\"\\s*:\\s*).*\"$"
let integerPattern = "^[0-9]+$"
let booleanPattern = "(^false|^true)"

let valuesPattern = "true|false|[0-9]+|\".*\""
let singleArrayPattern = "\\[\\s*(\(valuesPattern))(,\\s*(\(valuesPattern)))*\\s*\\]"
let singleObjectPattern = "\\{\\s*\".*\"\\s*:\\s*(\(valuesPattern))\\s*(,\\s*\".*\"\\s*:\\s*(\(valuesPattern)))*\\s*\\}"

//let nestedObjectPattern = "^\\{\\s*\".*\"\\s*:\\s*(\(singleObjectPattern)|\(singleArrayPattern)|\(valuesPattern))\\s*(,\\s*\".*\"\\s*:\\s*(\(singleObjectPattern)|\(singleArrayPattern)|\(valuesPattern))\\s*)*\\}$"
let nestedObjectPattern = "^\\{\\s*\".*\"\\s*:\\s*(\(valuesPattern)|\(singleArrayPattern)|\(singleObjectPattern))\\s*(,(\(valuesPattern)|\(singleArrayPattern)|\(singleObjectPattern)))*\\s*\\}$"
let nestedArrayPattern = "^\\[\\s*(\(valuesPattern)|(\(singleObjectPattern)|\(singleArrayPattern)))\\s*(,\\s*(\(valuesPattern)|(\(singleObjectPattern)|\(singleArrayPattern))))*\\s*\\]$"


func isSignleObject(target: String) -> [String] {
    let value = target as NSString
    if let regex = try? NSRegularExpression(pattern: singleObjectPattern, options: .caseInsensitive) {
        return regex.matches(in: target, options: [], range: NSRange(location: 0, length: value.length)).map {
            value.substring(with: $0.range)
        }
    }
    return []
}



func isObject(target: String) -> [String] {
    let value = target as NSString
    if let regex = try? NSRegularExpression(pattern: nestedObjectPattern, options: .caseInsensitive) {
        return regex.matches(in: target, options: [], range: NSRange(location: 0, length: value.length)).map {
            value.substring(with: $0.range)
        }
    }
    return []
}

func isSingleArray(target: String) -> [String] {
    let value = target as NSString
    if let regex = try? NSRegularExpression(pattern: singleArrayPattern, options: .caseInsensitive) {
        return regex.matches(in: target, options: [], range: NSRange(location: 0, length: value.length)).map {
            value.substring(with: $0.range)
        }
    }
    return []
}

func isArray(target: String) -> [String] {
    let value = target as NSString
    if let regex = try? NSRegularExpression(pattern: nestedArrayPattern, options: .caseInsensitive) {
        return regex.matches(in: target, options: [], range: NSRange(location: 0, length: value.length)).map {
            value.substring(with: $0.range)
        }
    }
    return []
}

let arrayText1 = "[\"key\", false, 5]"
print("------Single Array------")
isSingleArray(target: arrayText1).forEach {print($0)}
print("------------------------")
print("------Single Object------")
let objectText1 = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : [5], \"married\" : true }"
isSignleObject(target: objectText1).forEach {print($0)}
print("------------------------")
print("------Array Nested Object------")
let objectWithArrayText = "{ \"name\" : \"KIM JUNG\", \"child\" : [5, \"b\", true], \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
isObject(target: objectWithArrayText).forEach {print($0)}
print("------------------------")
print("------Object Nested Object------")
let objectWithObjectText = "{ \"name\" : \"KIM JUNG\", \"child\" : {\"married\" : true}, \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
isObject(target: objectWithObjectText).forEach {print($0)}
print("------------------------")
print("------Object Nested Array------")
let arrayWithObjectText = "[\"false\", 5, false, {\"key\":5}]"
isArray(target: arrayWithObjectText).forEach {print($0)}
print("------------------------")
print("------Array Nested Array------")
let arrayWithArrayText = "[\"false\", 5, false, [false, 5, \"asd\"]]"
isArray(target: arrayWithArrayText).forEach {print($0)}
print("------------------------")
print("------Double Nested Object------")
isObject(target: "{ \"name\" : \"KIM JUNG\", \"child\" : {\"age\": [5,4,2] }, \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }").forEach {print($0)}
