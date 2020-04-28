//
//  AppFormatter.swift
//  stackoverflow
//
//  Created by Innocent Magagula on 2020/04/28.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation

final class AppFormatter {
    
    static func format(_ number: Int) -> String {
        let num = Double(number)
        let thousandNum = num/1000
        let millionNum = num/1000000
        if num >= 10000 && num < 1000000{
            if(floor(thousandNum) == thousandNum){
                return("\(Int(thousandNum))k")
            }
            return("\(roundToPlaces(places: 1,number: thousandNum))k")
        }
        if num > 1000000{
            if(floor(millionNum) == millionNum){
                return("\(Int(thousandNum))k")
            }
            return ("\(roundToPlaces(places: 1,number: millionNum))M")
        }
        else{
            if(floor(num) == num){
                return String(format: "%ld", locale: Locale.current, (Int(num)))
            }
            return String(format: "%.0f", locale: Locale.current, num)
        }
    }
    
    static func roundToPlaces(places:Int, number: Double) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(number * divisor) / divisor
    }
}
