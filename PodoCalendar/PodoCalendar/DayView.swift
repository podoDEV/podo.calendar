//
//  DayView.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import SwiftDate

class DayView: UIView {

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .normalDayTextColor
        label.backgroundColor = .clear
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

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    func setup() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onSelected))
        addGestureRecognizer(tap)
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
        if isToday {
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

    func updateSelectUI(type: selectType) {
        switch type {
        case .begin:
            dateLabel.textColor = .selectedDayTextColor
            beginBackgroundView.backgroundColor = .selectedDayBackgroundColor
            middleBackgroundView.backgroundColor = .selectedDayBackgroundColor
            endBackgroundView.backgroundColor = .normalDayBackgroundColor
        case .single:
            dateLabel.textColor = .selectedDayTextColor
            beginBackgroundView.backgroundColor = .normalDayBackgroundColor
            middleBackgroundView.backgroundColor = .selectedDayBackgroundColor
            endBackgroundView.backgroundColor = .normalDayBackgroundColor
        case .end:
            dateLabel.textColor = .selectedDayTextColor
            beginBackgroundView.backgroundColor = .normalDayBackgroundColor
            middleBackgroundView.backgroundColor = .selectedDayBackgroundColor
            endBackgroundView.backgroundColor = .selectedDayBackgroundColor
        }
    }

    @objc func onSelected() {
        NotificationCenter.default.post(name: .dateDidSelected, object: self.date)
    }
}

extension NSNotification.Name {
    static let dateDidSelected = Notification.Name("date_did_selected")
}

enum selectType {
    case begin
    case single
    case end
}

struct Appearance {
    static var normalDayBackgroundColor = UIColor(hex: 0xF9F9F9)
    static var selectedDayBackgroundColor = UIColor(hex: 0xD6ABFB)
    static var todayBackgroundColor = UIColor(hex: 0xF9F9F9)
    static var normalDayTextColor = UIColor(hex: 0x9000FE)
    static var selectedDayTextColor = UIColor(hex: 0x9000FE)
    static var todayTextColor = UIColor(hex: 0x9000FE)
    static var otherMonthDayTextColor = UIColor(hex: 0xEEEEEE)
}

extension UIColor {

    static var normalDayBackgroundColor: UIColor {
        get { return Appearance.normalDayBackgroundColor }
        set { Appearance.normalDayBackgroundColor = newValue }
    }
    static var selectedDayBackgroundColor: UIColor {
        get { return Appearance.selectedDayBackgroundColor }
        set { Appearance.selectedDayBackgroundColor = newValue }
    }
    static var todayBackgroundColor: UIColor {
        get { return Appearance.todayBackgroundColor }
        set { Appearance.todayBackgroundColor = newValue }
    }
    static var normalDayTextColor: UIColor {
        get { return Appearance.normalDayTextColor }
        set { Appearance.normalDayTextColor = newValue }
    }
    static var selectedDayTextColor: UIColor {
        get { return Appearance.selectedDayTextColor }
        set { Appearance.selectedDayTextColor = newValue }
    }
    static var todayTextColor: UIColor {
        get { return Appearance.todayTextColor }
        set { Appearance.todayTextColor = newValue }
    }
    static var otherMonthDayTextColor: UIColor {
        get { return Appearance.otherMonthDayTextColor }
        set { Appearance.otherMonthDayTextColor = newValue }
    }
}
