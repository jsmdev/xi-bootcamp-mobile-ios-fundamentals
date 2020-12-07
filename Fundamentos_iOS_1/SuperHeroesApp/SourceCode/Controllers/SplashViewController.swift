//
//  SplashViewController.swift
//  Fundamentos_iOS_1
//
//  Created by José Sancho on 6/12/20.
//

import UIKit

class SplashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addAsyncDelay()
        navigationController?.isNavigationBarHidden = true
    }

    func addAsyncDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
            self?.nextViewController()
        }
    }

    func nextViewController() {
        let tabBarStoryboard = UIStoryboard(name: Storyboards.tabBar,
                                            bundle: nil)
        if let destination = tabBarStoryboard.instantiateInitialViewController() {
            navigationController?.setViewControllers([destination],
                                                     animated: true)
        }
    }
}
