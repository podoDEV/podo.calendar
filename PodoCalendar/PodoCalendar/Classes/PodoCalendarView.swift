//
//  PodoCalendarView.swift
//  PodoCalendar
//
//  Copyright © 2018 podo. All rights reserved.
//

import SwiftDate

public class PodoCalendarView: UIView {

    public weak var delegate: PodoCalendarViewDelegate?

    public var normalDayBackgroundColor: UIColor? {
        didSet {
            if let normalDayBackgroundColor = normalDayBackgroundColor {
                UIColor.normalDayBackgroundColor = normalDayBackgroundColor
            }
        }
    }

    public var selectedDayBackgroundColor: UIColor? {
        didSet {
            if let selectedDayBackgroundColor = selectedDayBackgroundColor {
                UIColor.selectedDayBackgroundColor = selectedDayBackgroundColor
            }
        }
    }

    public var todayBackgroundColor: UIColor? {
        didSet {
            if let todayBackgroundColor = todayBackgroundColor {
                UIColor.todayBackgroundColor = todayBackgroundColor
            }
        }
    }

    public var normalDayTextColor: UIColor? {
        didSet {
            if let normalDayTextColor = normalDayTextColor {
                UIColor.normalDayTextColor = normalDayTextColor
            }
        }
    }

    public var selectedDayTextColor: UIColor? {
        didSet {
            if let selectedDayTextColor = selectedDayTextColor {
                UIColor.selectedDayTextColor = selectedDayTextColor
            }
        }
    }

    public var todayTextColor: UIColor? {
        didSet {
            if let todayTextColor = todayTextColor {
                UIColor.todayTextColor = todayTextColor
            }
        }
    }

    public var otherMonthDayTextColor: UIColor? {
        didSet {
            if let otherMonthDayTextColor = otherMonthDayTextColor {
                UIColor.otherMonthDayTextColor = otherMonthDayTextColor
            }
        }
    }

    public var normalFont: UIFont? {
        didSet {
            if let normalFont = normalFont {
                UIFont.normalFont = normalFont
            }
        }
    }

    internal lazy var weekLabel: WeekLabelView = {
        let view = WeekLabelView()
        view.backgroundColor = .normalDayBackgroundColor
        return view
    }()

    internal lazy var calendarView: CalendarView = {
        let view = CalendarView()
        view.delegate = self
        return view
    }()

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public init() {
        super.init(frame: .zero)
        setup()
    }

    private func setup() {
        addSubview(weekLabel)
        addSubview(calendarView)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onSelected(notification:)),
                                               name: .dateDidSelected,
                                               object: nil)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        weekLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height/7)
        calendarView.frame = CGRect(x: 0, y: bounds.height/7, width: bounds.width, height: bounds.height/7 * 6)
        calendarView.contentOffset.x = bounds.width
        calendarView.selectDate(date: DateInRegion().dateAt(.startOfDay))
    }

    @objc private func onSelected(notification: NSNotification) {
        guard let date = notification.object as? DateInRegion else {
            return
        }

        calendarView.selectDate(date: date)
        if let delegate = delegate {
            delegate.calendarView(self, didSelectDate: date.date)
        }
    }
}

extension PodoCalendarView: UIScrollViewDelegate {

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = self.calendarView.contentOffset.x / self.calendarView.frame.width
        if position.isNaN {
            return
        }

        if position <= 0.0 || 2.0 <= position {
            calendarView.move(to: Direction(rawValue: Int(position))!)
        }
    }
}
