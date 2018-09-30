//
//  WeekLabelView.swift
//  PodoCalendar
//
//  Copyright © 2018 podo. All rights reserved.
//

internal class WeekLabelView: UIView {

    var weekLabels: [WeekLabel] = [WeekLabel(day: NSLocalizedString("Sunday", comment: "Sunday")),
                                   WeekLabel(day: NSLocalizedString("Monday", comment: "Monday")),
                                   WeekLabel(day: NSLocalizedString("Tuesday", comment: "Tuesday")),
                                   WeekLabel(day: NSLocalizedString("Wednesday", comment: "Wednesday")),
                                   WeekLabel(day: NSLocalizedString("Thursday", comment: "Thursday")),
                                   WeekLabel(day: NSLocalizedString("Friday", comment: "Friday")),
                                   WeekLabel(day: NSLocalizedString("Saturday", comment: "Saturday"))]

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    func setup() {
        for label in weekLabels {
            addSubview(label)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        var x: CGFloat = 0
        for label in weekLabels {
            label.frame = CGRect(x: x, y: 0, width: bounds.size.width / CGFloat(weekLabels.count), height: bounds.height)
            x = label.frame.maxX
        }
    }

    class WeekLabel: UILabel {

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
        }

        init(day: String) {
            super.init(frame: .zero)
            text = day
            textAlignment = .center
            textColor = .normalDayTextColor
            font = .boldSystemFont(ofSize: 10)
        }
    }
}
