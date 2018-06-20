import UIKit

class A {
    var a:Int = 5
}

var a = A()
var b = A()

var c = a

print("a idenitfier: \(ObjectIdentifier(a))")
print("b idenitfier: \(ObjectIdentifier(b))")
print("c idenitfier: \(ObjectIdentifier(c))")
