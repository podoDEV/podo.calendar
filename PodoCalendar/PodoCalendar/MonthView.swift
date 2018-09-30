//
//  MonthView.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import SwiftDate

class MonthView: UIView {

    var weeks = [WeekView]()
    var date: DateInRegion? {
        didSet {
            updateWeeks()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    func setup() {
        for _ in 0..<6 {
            let week = WeekView()
            addSubview(week)
            weeks.append(week)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        var y: CGFloat = 0
        for week in weeks {
            week.frame = CGRect(x: 0, y: y, width: bounds.size.width, height: bounds.size.height / CGFloat(weeks.count))
            y = week.frame.maxY
        }
    }

    func updateWeeks() {
        var date = self.date?.dateAt(.startOfWeek)
        for week in weeks {
            week.year = self.date?.year
            week.month = self.date?.month
            week.date = date
            date = date?.dateAt(.nextWeek)
        }
    }
}
