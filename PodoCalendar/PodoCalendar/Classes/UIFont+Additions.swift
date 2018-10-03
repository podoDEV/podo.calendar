//
//  UIFont+Additions.swift
//  PodoCalendar
//
//  Created by NHNEnt on 03/10/2018.
//  Copyright © 2018 podo. All rights reserved.
//

import UIKit

extension UIFont {
    static var normalFont: UIFont {
        get { return Appearance.normalFont }
        set { Appearance.normalFont = newValue }
    }
}
