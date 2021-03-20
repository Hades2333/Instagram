//
//  IGFeedPostHeaderTableViewCell.swift
//  Instagramm
//
//  Created by Hellizar on 14.03.21.
//

import UIKit

class IGFeedPostHeaderTableViewCell: UITableViewCell {

    static let identifier = "IGFeedPostHeaderTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBlue

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure() {
        // configure the cell
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }


}
