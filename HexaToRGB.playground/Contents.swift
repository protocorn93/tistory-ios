//: Playground - noun: a place where people can play

import Foundation

func hexaToRGB(from hex: Int) -> (Int, Int, Int){
    let r = (hex & 0xff0000) >> 16
    let g = (hex & 0x00ff00) >> 8
    let b = (hex & 0x0000ff)
    
    return (r, g, b)
}

let rgb = hexaToRGB(from: 0x2e34ab)
print("R : \(rgb.0) G : \(rgb.1) B : \(rgb.2)")
