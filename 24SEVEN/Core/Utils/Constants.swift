//
//  Constants.swift
//  24SEVEN
//
//  Created by Islom on 30/01/21.
//

import Foundation


struct Constants {
    static let logo = "24SevenLogo"
    
    static let navBarBack = "navBarBack"
    
    static let homeTab = "Home"
    
    static let categoryTab = "Category"
    
    static let cartTab = "Cart"
    
    static let userProfileTab = "UserProfile"
    
    static let search = "Search"
    
    static let microphone = "Microphone"
    
    static let scanner = "Scan"
    
    static let favorite = "Favorite"
    
    static let notFavorite = "NoFavorite"
    
    static let comments = "Comments"
    
    static let addToCart = "AddToCart"
    
    static let sort = "Sort"
    
    static let filter = "Filter"
    
    static let panButton = "PanButton"
    
    static let incrementButton = "Increment"
    
    static let decrementButton = "Decrement"
    
    static let removeButton = "Remove"
    
    static let chevronDown = "ChevronDown"
    
    static let map = "Map"
    
    static let payme = "Payme"
    
    static let click = "Click"
    
    static let success = "Success"
    
    static let chevronRight = "ChevronRight"
    
    static let mapPlaceholder = "MapPlaceholder"
    
    static let mainPayme = "MainPayme"
    
    static let mainClick = "MainClick"
    
    static let cash = "Cash"
    
    static let chechmarkOn = "Checkmark-on"
    
    static let chechmarkOff = "Checkmark-off"
    
    static let dateOfBirth = "DateOfBirth"
    
    static let telegram = "Telegram"
    
    static let facebook = "Facebook"
    
    static let instagram = "Instagram"
    
    static let largeLogo = "LargeLogo"
    
    static let location = "location"
    
    static let target = "target"
}

struct ConstantsAPIKey {
    public static var KEY_FOR_YANDEX_USAGE = "57ecb2b2-c00c-4c88-bbe0-04dea02b485f"
    public static var KEY_FOR_YANDEX_USAGE_MAP = "3ed625df-5659-43b9-837e-25384fc99d67"
}

public struct MockData {
    static let payment: [String] = ["Наличные", "transfer".localized(using: "Localizable")]
    static let gender: [String] = ["male".localized(using: "Localizable"), "female".localized(using: "Localizable")]
    static let sortTypes: [String] = ["new", "popular","cheap", "expensive"]
}
