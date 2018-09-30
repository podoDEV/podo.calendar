//
//  WeekLabelView.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

class WeekLabelView: UIView {

    var weekLabels: [WeekLabel] = [WeekLabel(day: "SUN"),
                                   WeekLabel(day: "MON"),
                                   WeekLabel(day: "TUE"),
                                   WeekLabel(day: "WED"),
                                   WeekLabel(day: "THU"),
                                   WeekLabel(day: "FRI"),
                                   WeekLabel(day: "SAT")]

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
