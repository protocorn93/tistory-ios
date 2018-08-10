//: Playground - noun: a place where people can play

import Cocoa

var rawValue = "{asdf:asdf}, {asfd}, {sss[]} [asdf]"

var invalidValue1 = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"
var invalidValue2 = "[ \"name\" : \"KIM JUNG\" ]"
var validValue1 = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
var validValue2 = "[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }, { \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true } ]"
/*
 .caseInsensitive : both uppercase and lowecase
*/

extension String {
    var isValid: Bool {
        return !isNested && !isPairInArray
    }
    
    private var isNested: Bool {
        if let regex = try? NSRegularExpression(pattern: "\\{(?:.+?)?(?:\\{|\\[)(?:.+?)?(?:\\}|\\])(?:.+?)?\\}", options: .caseInsensitive) {
            let string = self as NSString
            return !regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).isEmpty
        }
        return false
    }
    
    private var isPairInArray: Bool {
        if let regex = try? NSRegularExpression(pattern: "\\[[a-z0-9\"\\s]+:[a-z0-9\"\\s]+\\]", options: .caseInsensitive) {
            let string = self as NSString
            return !regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).isEmpty
        }
        
        return false
    }
}

struct JSONString {
    private var target: String
    
    init(target: String) {
        self.target = target
    }
    var keys: [String] {
        if let regex = try? NSRegularExpression(pattern: "\"[a-z]+\"\\s?(?=:)", options: .caseInsensitive) {
            let string = target as NSString
            return regex.matches(in: target, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range).replacingOccurrences(of: ":", with: "")
            }
        }
        return []
    }
    var values: [String] {
        if let regex = try? NSRegularExpression(pattern: "[^:]+(?=,|$)", options: .caseInsensitive) {
            let string = target as NSString
            return regex.matches(in: target, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range).replacingOccurrences(of: ":", with: "")
            }
        }
        return []
    }
    var objects: [String] {
        if let regex = try? NSRegularExpression(pattern: "[^\\{]+(?=\\})", options: .caseInsensitive) {
            let string = target as NSString
            return regex.matches(in: target, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range).replacingOccurrences(of: ":", with: "")
            }
        }
        return []
    }
}
let objects = JSONString(target: "{asdf}, {asdf}").objects
let values = JSONString(target: "\"name\": \"\"South Korea, United Kingdom\"").values
let keys = JSONString(target: "\"name\" : \"\"South Korea, United Kingdom\"").keys
values.forEach {print($0)}
keys.forEach {print($0)}
