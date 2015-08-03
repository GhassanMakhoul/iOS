//
//  DrizzyBase.swift
//  ViewsFromTheDriz
//
//  Created by Ghassan Makhoul on 7/30/15.
//  Copyright (c) 2015 Ghassan Makhoul. All rights reserved.
//

import Foundation

enum Lyric {
    case Drake(String)
    case Meek(String)
    
    var description: String {
        get {
            switch self {
            case .Drake(let lyrics): return lyrics
            case .Meek(let lyrics): return lyrics
            }
        }
    }
}

struct ImgBase {
    static let Meek = NSURL(string: "http://imc.ulximg.com/image/src/artist/1392673408_deb82fa8448da2d71c950397cbfc47d3.jpg/705b706c41f84f54ba3c9122ee32c768/1392673408_meek_mill2_84.jpg")
    static let startup = NSURL(string: "http://www.moniquedee.com/wp-content/uploads/2014/10/Screen-Shot-2014-10-27-at-11.34.34-PM.png")
    struct Drizzy {
        static let Momma = NSURL(string: "http://static.stereogum.com/blogs.dir/2/files/2014/12/Drake-and-his-mom-608x344.jpg")
        static let Afro = NSURL(string: "http://filmcolossus.com/wp-content/uploads/2014/03/drake2.jpg")
        static let NWTS = NSURL(string: "https://kellmill.files.wordpress.com/2014/01/tumblr_mryav9qwp71re1804o1_1280.jpg")
    }
    struct Lyrics {

        
        
        struct Drizzy {
            static let Worst_Behavior = "WURST!"
            static let WU = "Machine Gun Rap for all my niggahs in the back"
            static let Know_Yourself = "Running through the 6"
        }
    
        struct Meek {
            static let RICO = "I spend a day what you make a year"
            static let Lord_Knows = "Shout out to my bitches"
        }
    }
    
}

class DrizzyBase
{
    private var lyricBase: [Lyric]
    var totalLyrics: Int
    init() {
        lyricBase = [Lyric]()
        lyricBase.append(Lyric.Drake("WURST!"))
        lyricBase.append(Lyric.Drake("Machine Gun Rap for all my niggahs in the back"))
        lyricBase.append(Lyric.Drake("Running through the 6"))
        lyricBase.append(Lyric.Meek("I spend a day what you make a year"))
        lyricBase.append(Lyric.Meek("Shout out to my bitches"))
        totalLyrics = lyricBase.count
    }
    
    func addLyric(lyric: String, Rapper: String) {
        switch Rapper {
            case "Drake":  lyricBase.append(Lyric.Drake(lyric))
            case "Meek": lyricBase.append(Lyric.Meek(lyric))
        default: break
        }
    }
    
    func getRandomLyric() -> String{
        var selecter = Int(arc4random_uniform(UInt32(totalLyrics)))
        let retrieved = lyricBase[selecter]
        switch retrieved {
        case .Drake(let lyric): return lyric
        case .Meek(let lyric): return lyric
        }
    }
}











