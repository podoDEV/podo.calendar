//
//  CalendarUtils.swift
//  PodoCalendar
//
//  Copyright © 2018 podo. All rights reserved.
//

import Foundation

internal struct CalendarUtils {

    static var today = Date()

    static var calendar = Calendar.autoupdatingCurrent

    static func isToday(date: Date) -> Bool {
        let todayComps = dateComponentsOfDate(date: today)
        let dateComps = dateComponentsOfDate(date: date)
        return todayComps.year == dateComps.year
            && todayComps.month == dateComps.month
            && todayComps.day == dateComps.day
    }

    static func dateComponentsOfDate(date: Date) -> DateComponents {
        let comps = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .weekday, .weekOfMonth], from: date)
        return comps
    }
}
