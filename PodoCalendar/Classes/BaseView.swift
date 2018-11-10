//
//  BaseView.swift
//  PodoCalendar
//
//  Created by NHNEnt on 03/10/2018.
//  Copyright © 2018 podo. All rights reserved.
//

import Foundation

internal class BaseView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }

    func setup() {

    }
}
