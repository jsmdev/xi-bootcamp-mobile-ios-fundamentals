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
        addAsyncDelay(seconds: 5)
        navigationController?.isNavigationBarHidden = true
    }

    func addAsyncDelay(seconds: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.nextViewController()
        }
    }

    func nextViewController() {
        performSegue(withIdentifier: Constants.segueFromSplashToTabBar,
                     sender: nil)
    }
}
