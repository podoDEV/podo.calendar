//
//  PodoCalendarDelegate.swift
//  PodoCalendar
//
//  Copyright © 2018 podo. All rights reserved.
//

@objc public protocol PodoCalendarDelegate: NSObjectProtocol {
    @objc optional func calendarView(_ calendarView: PodoCalendar, didSelectDate date: Date)
    @objc optional func calendarView(_ calendarView: PodoCalendar, startedAt startDate: Date, finishedAt finishDate: Date)
}
