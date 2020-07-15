//
//  UIImageView+Fullscreen.swift
//  GiantGames
//
//  Created by Xavier on 14/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import UIKit

extension UIImageView {
    func goFullScreenOnTap(_ on: Bool) {
        if on {
            let tap = UITapGestureRecognizer(target: self,
                                             action: #selector(didTap(recognizer:)))
            tap.name = "didTap"
            addGestureRecognizer(tap)
        } else if let gesture = gestureRecognizers?.first(where: { $0.name == "didTap" }) {
            removeGestureRecognizer(gesture)
        }
    }

    @objc func didTap(recognizer: UITapGestureRecognizer) {
        let imageView = recognizer.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        newImageView.alpha = 0.0
        newImageView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                 action: #selector(dismissFullscreen(recognizer:))))
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            window.addSubview(newImageView)
            UIView.animate(withDuration: 0.25) { newImageView.alpha = 1.0 }
            window.topViewController()?.view.endEditing(true)
            window.topViewController()?.tabBarController?.tabBar.isHidden = true
        }
    }

    @objc func dismissFullscreen(recognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.25, animations: {
            recognizer.view?.alpha = 0.0
        }, completion: { _ in
            recognizer.view?.removeFromSuperview()
        })
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            window.topViewController()?.navigationController?.isNavigationBarHidden = false
            window.topViewController()?.tabBarController?.tabBar.isHidden = false
        }

    }
}
