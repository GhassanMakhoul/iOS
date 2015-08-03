//
//  FeudBrain.swift
//  ViewsFromTheDriz
//
//  Created by Ghassan Makhoul on 8/2/15.
//  Copyright (c) 2015 Ghassan Makhoul. All rights reserved.
//

import Foundation

class FeudBrain {
    private var scores: [String: Int]
    private var TotalLyrics: Int
    private var DBase: DrizzyBase
    
    init () {
        scores = [String: Int]()
        scores["Meek"] = 0
        scores["Drake"] = 0
        scores["Meek's Sister"] = 0
    
        DBase = DrizzyBase()
        TotalLyrics = DBase.totalLyrics
        
    }
    
    func getLyric() -> String {
       return DBase.getRandomLyric()
    }
    
}


