//
//  DayView.swift
//  PodoCalendar
//
//  Copyright © 2018 podo. All rights reserved.
//

import SwiftDate

internal protocol DayViewDelegate: NSObjectProtocol {
    func dayView(_ dayView: DayView, didSelectDate date: DateInRegion)
}

internal class DayView: BaseView {

    weak var delegate: DayViewDelegate?

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .normalDayTextColor
        label.backgroundColor = .clear
        label.font = .normalFont
        return label
    }()

    lazy var beginBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .normalDayBackgroundColor
        return view
    }()

    lazy var middleBackgroundView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .normalDayBackgroundColor
        return view
    }()

    lazy var endBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .normalDayBackgroundColor
        return view
    }()

    var date: DateInRegion? {
        didSet {
            self.dateLabel.text = "\((date?.day)!)"
        }
    }

    var isSameMonth: Bool = true {
        didSet {
            updateUI()
            if isSameMonth {
                let tap = UITapGestureRecognizer(target: self, action: #selector(onSelected))
                addGestureRecognizer(tap)
            }
        }
    }

    var isToday: Bool = false {
        didSet {
            updateUI()
        }
    }

    var isSelected: Bool = false {
        didSet {
            if isSelected {
                updateSelectUI(type: .single)
            } else {
                updateUI()
            }
        }
    }

    convenience init(_ delegate: DayViewDelegate) {
        self.init(frame: .zero)
        setup(delegate)
    }

    func setup(_ delegate: DayViewDelegate) {
        self.delegate = delegate
        addSubview(beginBackgroundView)
        addSubview(endBackgroundView)
        addSubview(middleBackgroundView)
        middleBackgroundView.addSubview(dateLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupBeginBackgroundView()
        setupMiddleBackgroundView()
        setupEndBackgroundView()
    }

    @objc func onSelected() {
        delegate?.dayView(self, didSelectDate: self.date!)
    }
}

private extension DayView {

    func setupBeginBackgroundView() {
        var cgRect = CGRect(x: bounds.width/2, y: 0, width: bounds.width/2, height: bounds.height)
        if bounds.height > bounds.width {
            cgRect = CGRect(x: bounds.width/2, y: (bounds.height - bounds.width)/2, width: bounds.width/2, height: bounds.width)
        }
        beginBackgroundView.frame = cgRect
    }

    func setupMiddleBackgroundView() {
        var cgRect = CGRect(x: (bounds.width - bounds.height)/2, y: 0, width: bounds.height, height: bounds.height)
        if bounds.height > bounds.width {
            cgRect = CGRect(x: 0, y: (bounds.height - bounds.width)/2, width: bounds.width, height: bounds.width)
        }
        middleBackgroundView.frame = cgRect
        middleBackgroundView.layer.cornerRadius = min(bounds.width, bounds.height)/2
        dateLabel.frame = middleBackgroundView.bounds
    }

    func setupEndBackgroundView() {
        var cgRect = CGRect(x: 0, y: 0, width: bounds.width/2, height: bounds.height)
        if bounds.height > bounds.width {
            cgRect = CGRect(x: 0, y: (bounds.height - bounds.width)/2, width: bounds.width/2, height: bounds.width)
        }
        endBackgroundView.frame = cgRect
    }

    func updateUI() {
        dateLabel.textColor = .normalDayTextColor
        beginBackgroundView.backgroundColor = .normalDayBackgroundColor
        endBackgroundView.backgroundColor = .normalDayBackgroundColor
        if isToday, isSameMonth {
            dateLabel.textColor = .todayTextColor
            middleBackgroundView.backgroundColor = .todayBackgroundColor
        } else if isSameMonth {
            dateLabel.textColor = .normalDayTextColor
            middleBackgroundView.backgroundColor = .normalDayBackgroundColor
        } else {
            dateLabel.textColor = .otherMonthDayTextColor
            middleBackgroundView.backgroundColor = .normalDayBackgroundColor
        }
    }

    func updateSelectUI(type: SelectType) {
        switch type {
        case .begin where isSameMonth:
            dateLabel.textColor = .selectedDayTextColor
            beginBackgroundView.backgroundColor = .selectedDayBackgroundColor
            middleBackgroundView.backgroundColor = .selectedDayBackgroundColor
            endBackgroundView.backgroundColor = .normalDayBackgroundColor
        case .begin:
            dateLabel.textColor = .otherMonthSelectedDayTextColor
            beginBackgroundView.backgroundColor = .otherMonthSelectedDayBackgroundColor
            middleBackgroundView.backgroundColor = .otherMonthSelectedDayBackgroundColor
            endBackgroundView.backgroundColor = .normalDayBackgroundColor
        case .single where isSameMonth:
            dateLabel.textColor = .selectedDayTextColor
            beginBackgroundView.backgroundColor = .normalDayBackgroundColor
            middleBackgroundView.backgroundColor = .selectedDayBackgroundColor
            endBackgroundView.backgroundColor = .normalDayBackgroundColor
        case .single:
            dateLabel.textColor = .otherMonthSelectedDayTextColor
            beginBackgroundView.backgroundColor = .normalDayBackgroundColor
            middleBackgroundView.backgroundColor = .otherMonthSelectedDayBackgroundColor
            endBackgroundView.backgroundColor = .normalDayBackgroundColor
        case .end where isSameMonth:
            dateLabel.textColor = .selectedDayTextColor
            beginBackgroundView.backgroundColor = .normalDayBackgroundColor
            middleBackgroundView.backgroundColor = .selectedDayBackgroundColor
            endBackgroundView.backgroundColor = .selectedDayBackgroundColor
        case .end:
            dateLabel.textColor = .otherMonthSelectedDayTextColor
            beginBackgroundView.backgroundColor = .normalDayBackgroundColor
            middleBackgroundView.backgroundColor = .otherMonthSelectedDayBackgroundColor
            endBackgroundView.backgroundColor = .otherMonthSelectedDayBackgroundColor
        }
    }
}
