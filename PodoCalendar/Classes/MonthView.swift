//
//  MonthView.swift
//  PodoCalendar
//
//  Copyright © 2018 podo. All rights reserved.
//

import SwiftDate

internal class MonthView: BaseView {

    var weeks = [WeekView]()
    var date: DateInRegion? {
        didSet {
            updateWeeks()
        }
    }

    convenience init(_ delegate: DayViewDelegate) {
        self.init(frame: .zero)
        setup(delegate)
    }

    func setup(_ delegate: DayViewDelegate) {
        for _ in 0..<6 {
            let week = WeekView(delegate)
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
