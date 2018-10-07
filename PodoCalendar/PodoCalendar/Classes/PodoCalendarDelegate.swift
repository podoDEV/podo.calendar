//
//  PodoCalendarDelegate.swift
//  PodoCalendar
//
//  Copyright © 2018 podo. All rights reserved.
//

public protocol PodoCalendarDelegate: NSObjectProtocol {

    func calendarView(_ calendarView: PodoCalendar, didSelectDate date: Date)
    func calendarView(_ calendarView: PodoCalendar, startedAt startDate: Date, finishedAt finishDate: Date)
}

extension PodoCalendarDelegate {

    func calendarView(_ calendarView: PodoCalendar, didSelectDate date: Date) {}
    func calendarView(_ calendarView: PodoCalendar, startedAt start: Date, finishedAt finish: Date) {}
}
