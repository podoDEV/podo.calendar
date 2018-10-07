//
//  UIColor+Additions.swift
//  PodoCalendar
//
//  Copyright © 2018 podo. All rights reserved.
//

import UIKit

internal struct Appearance {
    static var normalDayBackgroundColor = UIColor(hex: 0xFFFFFF)
    static var selectedDayBackgroundColor = UIColor(hex: 0xD6ACFB)
    static var otherMonthSelectedDayBackgroundColor = UIColor(hex: 0xE6CAFD)
    static var todayBackgroundColor = UIColor(hex: 0xFFFFFF)
    static var normalDayTextColor = UIColor(hex: 0x9013FE)
    static var selectedDayTextColor = UIColor(hex: 0x9013FE)
    static var otherMonthSelectedDayTextColor = UIColor(hex: 0xAD49FE)
    static var todayTextColor = UIColor(hex: 0x9013FE)
    static var otherMonthDayTextColor = UIColor(hex: 0xEEEEEE)
    static var normalFont: UIFont = .boldSystemFont(ofSize: 11)
}

extension UIColor {

    internal convenience init(red: Int, green: Int, blue: Int, av: Float) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(av))
    }

    internal convenience init(hex: Int, alpha: Float = 1.0) {
        self.init(red: (hex >> 16) & 0xff, green: (hex >> 8) & 0xff, blue: hex & 0xff, av: alpha)
    }
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
    static var otherMonthSelectedDayBackgroundColor: UIColor {
        get { return Appearance.otherMonthSelectedDayBackgroundColor }
        set { Appearance.otherMonthSelectedDayBackgroundColor = newValue }
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
    static var otherMonthSelectedDayTextColor: UIColor {
        get { return Appearance.otherMonthSelectedDayTextColor }
        set { Appearance.otherMonthSelectedDayTextColor = newValue }
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
