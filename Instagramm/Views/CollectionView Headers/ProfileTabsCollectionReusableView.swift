//
//  ProfileTabsCollectionReusableView.swift
//  Instagramm
//
//  Created by Hellizar on 14.03.21.
//

import UIKit

class ProfileTabsCollectionReusableView: UICollectionReusableView {
        static let identifier = "ProfileTabsCollectionReusableView"

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
