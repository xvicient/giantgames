//
//  GameDetailViewController.swift
//  GiantGames
//
//  Created by Xavier on 13/07/2020.
//  Copyright © 2020 GiantGames All rights reserved.
//

import UIKit

struct GameDetailViewData: Equatable {
    let gameName: String
    let gameStoryline: String?
    let imagesTitle: String
    let videosTitle: String
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
    @IBOutlet private var imageCollectionView: GameDetailMediaCollectionView! {
        didSet {
            imageCollectionView.mediaDelegate = self
            imageCollectionView.type = .image
        }
    }
    @IBOutlet private var videosView: UIView!
    @IBOutlet private var videoCollectionView: GameDetailMediaCollectionView! {
        didSet {
            videoCollectionView.mediaDelegate = self
            videoCollectionView.type = .video
        }
    }
    @IBOutlet private var imagesTitleLabel: UILabel!
    @IBOutlet private var videosTitleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        onViewDidLoad()
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
        case let .showScreenshots(data):
            showScreenshots(data)
        case let .showVideos(data):
            showVideos(data)
        case let .showFullscreen(url):
            showFullscreen(url)
        }
    }
}

// MARK: - Private

private extension GameDetailViewController {
    func onViewDidLoad() {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    func showView(_ data: GameDetailViewData) {
        ganeNameLabel.text = data.gameName
        gameStorylineLabel.text = data.gameStoryline
        imagesTitleLabel.text = data.imagesTitle
        videosTitleLabel.text = data.videosTitle
    }

    func showCover(_ url: URL) {
        coverImageView.load(url: url)
    }

    func showScreenshots(_ urls: [URL]) {
        imageCollectionView.urls = urls
        imagesView.isHidden = false
        UIView.animate(withDuration: 0.25) { [unowned self] in
            self.imagesView.alpha = 1.0
        }
    }

    func showVideos(_ urls: [URL]) {
        videoCollectionView.urls = urls
        videosView.isHidden = false
        UIView.animate(withDuration: 0.25) { [unowned self] in
            self.videosView.alpha = 1.0
        }
    }

    func showFullscreen(_ url: URL) {
        guard let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window else { return }

        let imageView = UIImageView()
        imageView.load(url: url)
        imageView.frame = UIScreen.main.bounds
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.isUserInteractionEnabled = true
        imageView.alpha = 0.0
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                              action: #selector(dismissFullscreen(recognizer:))))
        window.addSubview(imageView)
        UIView.animate(withDuration: 0.25) { imageView.alpha = 1.0 }
    }

    @objc func dismissFullscreen(recognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.25, animations: {
            recognizer.view?.alpha = 0.0
        }, completion: { _ in
            recognizer.view?.removeFromSuperview()
        })
    }
}

// MARK: - GameDetailMediaCollectionViewDelegatePrivate

extension GameDetailViewController: GameDetailMediaCollectionViewDelegate {
    func didSelectVideo(_ index: Int) {
        presenter.didSelectVideo(index)
    }

    func didSelectImage(_ index: Int) {
        presenter.didSelectImage(index)
    }
}
