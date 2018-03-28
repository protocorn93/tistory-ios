//: Playground - noun: a place where people can play

import Cocoa

let fileManager = FileManager()

let url = "/Users/dongkun/Programming/Swift/tistory"
let documentDirectory = fileManager.urls(for: .documentationDirectory, in: .userDomainMask)
do {
    let contents = try fileManager.contentsOfDirectory(atPath: url)
    print(contents)
} catch let err {
    print(err)
}
