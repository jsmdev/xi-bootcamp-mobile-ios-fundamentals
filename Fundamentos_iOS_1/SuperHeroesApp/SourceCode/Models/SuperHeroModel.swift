//
//  SuperHeroModel.swift
//  Fundamentos_iOS_1
//
//  Created by José Sancho on 6/12/20.
//
// To parse the JSON, add this file to your project and do:
//
//   let superHero = try? newJSONDecoder().decode(SuperHero.self, from: jsonData)

import Foundation

// MARK: - SuperHeroElement
struct SuperHeroElement {
    let id: Int
    let name, slug: String
    let powerstats: Powerstats
    let appearance: Appearance
    let biography: Biography
    let work: Work
    let connections: Connections
    let images: Images
}

// MARK: - Appearance
struct Appearance {
    let gender: Gender
    let race: String?
    let height, weight: [String]
    let eyeColor, hairColor: String
}

enum Gender {
    case empty
    case female
    case male
}

// MARK: - Biography
struct Biography {
    let fullName, alterEgos: String
    let aliases: [String]
    let placeOfBirth, firstAppearance: String
    let publisher: String?
    let alignment: Alignment
}

enum Alignment {
    case bad
    case empty
    case good
    case neutral
}

// MARK: - Connections
struct Connections {
    let groupAffiliation, relatives: String
}

// MARK: - Images
struct Images {
    let xs, sm, md, lg: String
}

// MARK: - Powerstats
struct Powerstats {
    let intelligence, strength, speed, durability: Int
    let power, combat: Int
}

// MARK: - Work
struct Work {
    let occupation, base: String
}
