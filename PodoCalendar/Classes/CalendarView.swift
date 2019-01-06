//
//  CalendarView.swift
//  PodoCalendar
//
//  Copyright © 2018 podo. All rights reserved.
//

import SwiftDate

internal class CalendarView: UIScrollView {

    var months = [MonthView]()
    var selectedDate: DateInRegion?
    var loadedMonthsWidth: CGFloat {
        get {
            return bounds.size.width * CGFloat(months.count)
        }
    }

    convenience init(_ delegate: DayViewDelegate) {
        self.init(frame: .zero)
        setup(delegate)
    }

    private func setup(_ delegate: DayViewDelegate) {
        isPagingEnabled = true
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false

        var date = DateInRegion().dateAt(.prevMonth)
        for _ in 0..<3 {
            let month = MonthView(delegate)
            month.date = date
            addSubview(month)
            months.append(month)
            date = date.dateAt(.nextMonth)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        var x: CGFloat = 0
        for month in months {
            month.frame = CGRect(x: x, y: 0, width: bounds.size.width, height: bounds.size.height)
            x = month.frame.maxX
        }
        contentSize = CGSize(width: loadedMonthsWidth, height: bounds.size.height)
    }
}

internal extension CalendarView {

    func update(_ dateInRegion: DateInRegion) {
        var date = dateInRegion.dateAt(.prevMonth)
        for month in months {
            month.date = date
            date = date.dateAt(.nextMonth)
        }
        selectDate(date: dateInRegion)
    }

    func move(to toDirection: Direction) {
        let page1 = months[0]
        let page2 = months[1]
        let page3 = months[2]

        let prevX = page1.frame.origin.x
        let currentX = page2.frame.origin.x
        let nextX = page3.frame.origin.x

        if toDirection == .prev {
            page1.frame.origin.x = currentX
            page2.frame.origin.x = nextX
            page3.frame.origin.x = prevX
            page3.date = page1.date?.dateAt(.prevMonth)
            months = [page3, page1, page2]
            contentOffset.x = frame.width
        }

        if toDirection == .next {
            page1.frame.origin.x = nextX
            page2.frame.origin.x = prevX
            page3.frame.origin.x = currentX
            page1.date = page3.date?.dateAt(.nextMonth)
            months = [page2, page3, page1]
            contentOffset.x = frame.width
        }
        selectDate(date: selectedDate!)
    }

    private func selectDate(date: DateInRegion) {
        selectedDate = date
        let selectedDateComps = CalendarUtils.dateComponentsOfDate(date: date.date)
        for month in months {
            for week in month.weeks {
                for day in week.days {
                    if let date = day.date,
                        date.year == selectedDateComps.year,
                        date.month == selectedDateComps.month,
                        date.day == selectedDateComps.day {
                        day.isSelected = true
                    } else {
                        day.isSelected = false
                    }
                }
            }
        }
    }
}

internal extension CalendarView {
    internal enum Direction: Int {
        case prev = 0
        case next = 2
    }
}
