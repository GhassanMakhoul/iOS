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
        if let dvc = segue.destinationViewController as? DrizzyViewController {
        if let identifier = segue.identifier {
            switch identifier {
                case "Momma":
                    dvc.imageURL = DrizzyBase.Drizzy.Momma
                    dvc.title = identifier
                case "Afro":
                    dvc.imageURL = DrizzyBase.Drizzy.Afro
                    dvc.title = identifier

                case "NWTS":
                    dvc.imageURL = DrizzyBase.Drizzy.NWTS
                    dvc.title =  "Nothing Was The Same"


                case "Meek" :
                    dvc.imageURL = DrizzyBase.Meek
                    dvc.title = identifier
            default: break
                
            }
            }
        }
    }

}
