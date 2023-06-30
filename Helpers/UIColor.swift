//
//  UIColor.swift
//  ImageFeed
//
//  Created by Iurii on 30.06.23.
//

import UIKit

extension UIColor {
    static var ypBlue: UIColor { UIColor(named: "YP Blue") ?? UIColor.blue }
    static var ypRed: UIColor { UIColor(named: "YP Red") ?? UIColor.red }
    static var ypBlack: UIColor { UIColor(named: "YP Black") ?? UIColor.black}
    static var ypBackground: UIColor { UIColor(named: "YP Background") ?? UIColor.darkGray }
    static var ypGray: UIColor { UIColor(named: "YP Gray") ?? UIColor.gray }
    static var ypWhite: UIColor { UIColor(named: "YP White") ?? UIColor.white}
    static var ypWhiteAlpha: UIColor { UIColor(named: "YP White (Alpha 50)") ?? UIColor.white.withAlphaComponent(0.5)}
}
