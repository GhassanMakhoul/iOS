//
//  DrizzyDetailViewController.swift
//  ViewsFromTheDriz
//
//  Created by Ghassan Makhoul on 7/30/15.
//  Copyright (c) 2015 Ghassan Makhoul. All rights reserved.
//

import UIKit

class DrizzyDetailViewController: UIViewController {

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController as? UIViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController
        }
        if let dvc = destination as? DrizzyViewController {
            print("o")
            if let identifier = segue.identifier {
                switch identifier {
                case "Momma":
                    dvc.imageURL = ImgBase.Drizzy.Momma
                    dvc.title = identifier
                case "Afro":
                    dvc.imageURL = ImgBase.Drizzy.Afro
                    dvc.title = identifier

                case "NWTS":
                    dvc.imageURL = ImgBase.Drizzy.NWTS
                    dvc.title =  "Nothing Was The Same"


                case "Meek" :
                    dvc.imageURL = ImgBase.Meek
                    dvc.title = identifier
            default: break
                
            }
            }
        
        }
        if let lvc = destination as? LyricViewController {
            if let identifier = segue.identifier{
                switch identifier {
                    case "Play Game": lvc.title = "How rapped it?"
                    default: break
                    
                }
            }
        }
    }

}
