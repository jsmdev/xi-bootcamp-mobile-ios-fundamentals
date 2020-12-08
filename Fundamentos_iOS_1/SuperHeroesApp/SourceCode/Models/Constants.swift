//
//  Constants.swift
//  Fundamentos_iOS_1
//
//  Created by José Sancho on 7/12/20.
//

import Foundation

// MARK: - Segues
struct Segues {
    static let fromSplashToTabBar: String = "SEGUE_FROM_SPLASH_TO_TAB_BAR"
    static let fromDCToDetail: String = "SEGUE_FROM_DC_TO_DETAIL"
    static let fromMarvelToDetail: String = "SEGUE_FROM_MARVEL_TO_DETAIL"
    static let fromAllSuperHeroesToDetail: String = "SEGUE_FROM_ALL_SUPER_HEROES_TO_DETAIL"
}

// MARK: - Storyboards
struct Storyboards {
    static let tabBar: String = "TabBar"
    static let detail: String = "TabBar"
}

// MARK: - Cells
struct Cells {
    static let marvel: String = String(describing: MarvelTableViewCell.self)
    static let superHeroCollection: String = String(describing: SuperHeroCollectionViewCell.self)
}

// MARK: - Values
struct Values {
    static let cornerRadius: Float = 12.0
    static let shadowOpacity: Float = 0.7
}
