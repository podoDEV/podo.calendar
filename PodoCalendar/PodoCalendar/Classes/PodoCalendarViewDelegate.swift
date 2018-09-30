//
//  PodoCalendarViewDelegate.swift
//  PodoCalendar
//
//  Copyright © 2018 podo. All rights reserved.
//

public protocol PodoCalendarViewDelegate: NSObjectProtocol {

    func calendarView(_ calendarView: PodoCalendarView, didSelectDate date: Date)
    func calendarView(_ calendarView: PodoCalendarView, startedAt startDate: Date, finishedAt finishDate: Date)
}

extension PodoCalendarViewDelegate {

    func calendarView(_ calendarView: PodoCalendarView, didSelectDate date: Date) {}
    func calendarView(_ calendarView: PodoCalendarView, startedAt start: Date, finishedAt finish: Date) {}
}
