//
//  ViewController.swift
//  Instagramm
//
//  Created by Hellizar on 6.03.21.
//

import FirebaseAuth
import UIKit

struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}

class HomeViewController: UIViewController {

    private var feedRenderModels = [HomeFeedRenderViewModel]()

    private let tableView: UITableView = {
        let tableView = UITableView()
        
        //MARK: - Register cells
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        createMockModels()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func createMockModels() {
        let user = User(username: "Joe", bio: "",
                        name: (first: "", last: ""),
                        profilePhoto: URL(string: "https://www.google.com")!,
                        birthdate: Date(),
                        gender: .male,
                        counts: UserCount(followers: 1,
                                          following: 1,
                                          posts: 1),
                        joinDate: Date())
        let post = UserPost(identifier: "",
                            postType: .photo,
                            thumbnailImage: URL(string: "https://www.google.com")!,
                            postURL: URL(string: "https://www.google.com")!,
                            caption: nil,
                            likeCount: [],
                            comments: [],
                            createdDate: Date(),
                            taggedUsers: [],
                            owner: user)

        var comments = [PostComment]()
        for x in 0..<2 {
            comments.append(PostComment(identifier: "\(x)",
                                        username: "@Jenny",
                                        text: "This is the best post I've ever seen",
                                        createdDate: Date(),
                                        likes: []))
        }

        for x in 0..<4 {
            let viewModel =
                HomeFeedRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)),
                                        post: PostRenderViewModel(renderType: .primaryContent(provider: post)),

                                        actions: PostRenderViewModel(renderType: .actions(provider: "")),
                                        comments: PostRenderViewModel(renderType: .comments(comments: comments)))

            feedRenderModels.append(viewModel)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        handleNotAuthenticated()
    }

    func handleNotAuthenticated() {
        if Auth.auth().currentUser == nil {
            // show login
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        feedRenderModels.count * 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        let model: HomeFeedRenderViewModel
        if section == 0 {
            model = feedRenderModels[0]
        } else {
            let postion = x % 4 == 0 ? x/4 : ((x-(x%4))/4)
            model = feedRenderModels[postion]
        }

        let subSection = x % 4

        if subSection == 0 {
            //header
            return 1
        } else if subSection == 1 {
            //post
            return 1
        } else if subSection == 2 {
            //actions
            return 1
        } else if subSection == 3 {
            //comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let comments):
                return comments.count > 2 ? 2 : comments.count
            case .header, .actions, .primaryContent:
            return 0
            }
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        } else {
            let postion = x % 4 == 0 ? x/4 : ((x-(x%4))/4)
            model = feedRenderModels[postion]
        }

        let subSection = x % 4

        if subSection == 0 {
            //header
            let headerModel = model.header
            switch headerModel.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
                return cell
            case .comments, .actions, .primaryContent:
            return UITableViewCell()
            }

        } else if subSection == 1 {
            //post
            let postModel = model.post
            switch postModel.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
                return cell
            case .header, .actions, .comments:
                return UITableViewCell()
            }

        } else if subSection == 2 {
            //actions
            let actionModel = model.actions
            switch actionModel.renderType {
            case .actions(let provider):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
                return cell
            case .comments, .header, .primaryContent:
                return UITableViewCell()
            }

        } else if subSection == 3 {
            //comments
            let commentModel = model.comments
            switch commentModel.renderType {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                return cell
            case .header, .actions, .primaryContent:
                return UITableViewCell()
            }
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section % 4

        if subSection == 0 {
            return 70
        } else if subSection == 1 {
            return tableView.width
        } else if subSection == 2 {
            return 60
        } else if subSection == 3 {
            return 50
        }
        return 0
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subSection = section % 4
        return subSection == 3 ? 70 : 0
    }
}
