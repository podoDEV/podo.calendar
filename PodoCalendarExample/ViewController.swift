//
//  ViewController.swift
//  Example
//
//  Copyright © 2018 podo. All rights reserved.
//

import UIKit
import PodoCalendar

class ViewController: UIViewController {

    var calendarView: PodoCalendar!

    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView = PodoCalendar()
        calendarView.delegate = self
        view.addSubview(calendarView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let layoutInset = view.layoutInsets()
        calendarView.frame = CGRect(x: 0, y: 0 + layoutInset.top, width: view.bounds.width, height: 350)
    }
}

extension ViewController: PodoCalendarDelegate {

    func calendarView(_ calendarView: PodoCalendar, didSelectDate date: Date) {

    }
}
