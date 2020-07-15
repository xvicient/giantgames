//
//  GameDetailViewController.swift
//  GiantGames
//
//  Created by Xavier on 13/07/2020.
//  Copyright © 2020 GiantGames All rights reserved.
//

import UIKit

struct GameDetailViewData {
    let gameName: String
    let gameStoryline: String?
    let imagesTitle: String
    let videosTitle: String
}

struct GameDetailViewMediaData {
    let type: MediaType
    let urls: [URL]

    enum MediaType {
        case image
        case video
    }
}

final class GameDetailViewController: UIViewController {
    var presenter: GameDetailPresenterProtocol!
    @IBOutlet private var coverImageView: UIImageView! {
        didSet {
            coverImageView.roundCorners(radius: coverImageView.frame.size.width / 2)
        }
    }
    @IBOutlet private var ganeNameLabel: UILabel!
    @IBOutlet private var gameStorylineLabel: UILabel!
    @IBOutlet private var imagesView: UIView!
    @IBOutlet private var imageCollectionView: GameDetailMediaCollectionView!
    @IBOutlet private var videosView: UIView!
    @IBOutlet private var videoCollectionView: GameDetailMediaCollectionView!
    @IBOutlet private var imagesTitleLabel: UILabel!
    @IBOutlet private var videosTitleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - GameDetailViewProtocol

extension GameDetailViewController: GameDetailViewProtocol {
    func render(state: GameDetailViewState) {
        switch state {
        case let .showView(data):
            showView(data)
        case let .showCover(url):
            showCover(url)
        case let .showMedia(data):
            showMedia(data)
        }
    }
}

// MARK: - Private

private extension GameDetailViewController {
    func showView(_ data: GameDetailViewData) {
        ganeNameLabel.text = data.gameName
        gameStorylineLabel.text = data.gameStoryline
        imagesTitleLabel.text = data.imagesTitle
        videosTitleLabel.text = data.videosTitle
    }

    func showCover(_ url: URL) {
        coverImageView.load(url: url)
    }

    func showMedia(_ data: GameDetailViewMediaData) {
        switch data.type {
        case .image:
            imagesView.isHidden = false
            imageCollectionView.show(data)
        case .video:
            videosView.isHidden = false
            videoCollectionView.show(data)
        }
    }
}
