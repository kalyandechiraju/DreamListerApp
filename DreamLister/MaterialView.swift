//
//  MaterialView.swift
//  DreamLister
//
//  Created by Kalyan Dechiraju on 28/03/17.
//  Copyright © 2017 Codelight Studios. All rights reserved.
//

import UIKit

private var materialDesignSelected = false

extension UIView {
    
    @IBInspectable var materialDesign: Bool {
        get {
            return materialDesignSelected
        } set {
            materialDesignSelected = newValue
            
            if materialDesignSelected {
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 3.0
                self.layer.shadowOpacity = 0.8
                self.layer.shadowRadius = 3.0
                self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                self.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor
            } else {
                //self.layer.masksToBounds = true
                self.layer.cornerRadius = 0
                self.layer.shadowOpacity = 0
                self.layer.shadowRadius = 0
                self.layer.shadowColor = nil
            }
        }
    }

}
