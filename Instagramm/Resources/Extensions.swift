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

    public var height: CGFloat {
        return frame.size.height
    }

    public var top: CGFloat {
        return frame.origin.y
    }

    public var bottom: CGFloat {
        return frame.origin.y + frame.size.height
    }

    public var left: CGFloat {
        return frame.origin.x
    }

    public var right: CGFloat {
        return frame.origin.x + frame.size.width
    }

    //MARK: - Methods
    public func addSubviews(views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
}

extension String {
    func safeDatabaseKey() -> String {
        return replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
    }
}
