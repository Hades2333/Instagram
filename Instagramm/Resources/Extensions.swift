//
//  Extensions.swift
//  Instagramm
//
//  Created by Hellizar on 7.03.21.
//

import UIKit

extension UIView {

    public var width: CGFloat {
        return frame.size.width
    }

    //MARK: - Methods
    public func addSubviews(views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
}
