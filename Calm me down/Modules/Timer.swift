//
//  Timer.swift
//  Calm me down
//
//  Created by Olga Garus on 11.01.2024.
//

import Foundation

struct TimerSet {
    
    
    func getTimerValue(minutes: Int) -> String {
        let minuteString = minutes < 10 ? "0\(minutes):00" : "\(minutes):00"
        return minuteString
    }
}

