//
//  ViewController.swift
//  Example
//
//  Created by NHNEnt on 30/09/2018.
//  Copyright © 2018 podo. All rights reserved.
//

import UIKit
import PodoCalendar

class ViewController: UIViewController {

    var calendarView: PodoCalendar!

    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView = PodoCalendar()
        self.view.addSubview(calendarView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let layoutInset = view.layoutInsets()
        calendarView.frame = CGRect(x: 0, y: 0 + layoutInset.top, width: view.bounds.width, height: view.bounds.width)
    }
}
