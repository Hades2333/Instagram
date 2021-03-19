//
//  ProfileInfoCollectionReusableView.swift
//  Instagramm
//
//  Created by Hellizar on 14.03.21.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView)
}

final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {

    //MARK: - Properties
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?

    //MARK: - GUI variables
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let postsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Posts", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()

    private let followingButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Following", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()

    private let followersButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Followers", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()

    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Edit yout profile", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "John Smith"
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()

    private let bioLabel: UILabel = {
        let label = UILabel()
        label.text = "This is a first account!"
        label.textColor = .label
        label.numberOfLines = 0

        return label
    }()

    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addButtonActions()
        backgroundColor = .systemBackground
        clipsToBounds = true
    }

    private func addButtonActions() {
        followersButton.addTarget(self,
                                  action: #selector(didTapFollowersButton),
                                  for: .touchUpInside)
        followingButton.addTarget(self,
                                  action: #selector(didTapFollowingButton),
                                  for: .touchUpInside)
        postsButton.addTarget(self,
                                  action: #selector(didTapPostsButton),
                                  for: .touchUpInside)
        editProfileButton.addTarget(self,
                                  action: #selector(didTapEditProfileButton),
                                  for: .touchUpInside)
    }

    private func addSubviews() {
        addSubview(profilePhotoImageView)
        addSubview(postsButton)
        addSubview(followingButton)
        addSubview(followersButton)
        addSubview(editProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let profilePhotoSize = width/4
        profilePhotoImageView.frame = CGRect(
            x: 5, y: 5,
            width: profilePhotoSize,
            height: profilePhotoSize).integral

        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2.0

        let buttonHeight = profilePhotoSize/2
        let countButtonWidth = (width-10-profilePhotoSize)/3

        postsButton.frame = CGRect(
            x: profilePhotoImageView.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight).integral

        followersButton.frame = CGRect(
            x: postsButton.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight).integral

        followingButton.frame = CGRect(
            x: followersButton.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight).integral

        editProfileButton.frame = CGRect(
            x: profilePhotoImageView.right,
            y: 5+buttonHeight,
            width: countButtonWidth*3,
            height: buttonHeight).integral

        nameLabel.frame = CGRect(
            x: 5,
            y: 5+profilePhotoImageView.bottom,
            width: width - 10,
            height: 50).integral

        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        bioLabel.frame = CGRect(
            x: 5,
            y: 5+nameLabel.bottom,
            width: width - 10,
            height: bioLabel.height).integral
    }

    //MARK: - Actions

    @objc private func didTapFollowersButton() {
        // convey to the ViewController what happend
        delegate?.profileHeaderDidTapFollowersButton(self)
    }

    @objc private func didTapFollowingButton() {
        delegate?.profileHeaderDidTapFollowingButton(self)
    }

    @objc private func didTapPostsButton() {
        delegate?.profileHeaderDidTapPostsButton(self)
    }

    @objc private func didTapEditProfileButton() {
        delegate?.profileHeaderDidTapEditProfileButton(self)
    }

}
