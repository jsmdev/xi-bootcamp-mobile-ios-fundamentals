//
//  SuperHeroModel.swift
//  Fundamentos_iOS_1
//
//  Created by José Sancho on 6/12/20.
//

import Foundation

// MARK: - SuperHeroElement
struct SuperHeroElement: Codable {
    let id: Int
    let name, slug: String
    let powerstats: Powerstats
    let appearance: Appearance
    let biography: Biography
    let work: Work
    let connections: Connections
    let images: Images
    var isFavorite: Bool?
}

// MARK: - Appearance
struct Appearance: Codable {
    let gender: Gender
    let race: String?
    let height, weight: [String]
    let eyeColor, hairColor: String
}

enum Gender: String, Codable {
    case undefined = "-"
    case female = "Female"
    case male = "Male"
}

// MARK: - Biography
struct Biography: Codable {
    let fullName, alterEgos: String
    let aliases: [String]
    let placeOfBirth, firstAppearance: String
    let publisher: String?
    let alignment: Alignment
}

enum Alignment: String, Codable {
    case bad = "bad"
    case good = "good"
    case neutral = "neutral"
}

// MARK: - Connections
struct Connections: Codable {
    let groupAffiliation, relatives: String
}

// MARK: - Images
struct Images: Codable {
    let xs, sm, md, lg: String
}

// MARK: - Powerstats
struct Powerstats: Codable {
    let intelligence, strength, speed, durability: Int
    let power, combat: Int
}

// MARK: - Work
struct Work: Codable {
    let occupation, base: String
}

// MARK: - Publisher
enum Publisher: String {
    case dc = "DC Comics"
    case marvel = "Marvel Comics"
}

typealias SuperHeroes = [SuperHeroElement]
