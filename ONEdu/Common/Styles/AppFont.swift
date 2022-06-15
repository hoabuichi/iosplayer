//
//  AppFont.swift
//  ONSports
//
//  Created by Dao Thuy on 7/5/21.
//

import UIKit
import CoreText

enum AppFont: String {
    case light = "Quicksand-Light"
    case bold = "Quicksand-Bold"
    case semiBold = "Quicksand-SemiBold"
    case regular = "Quicksand-Regular"
    case medium = "Quicksand-Medium"
    
    func of(style: DynamicType) -> UIFont {
        guard let size = fontSizes[style],
              let font = UIFont(name: self.rawValue, size: size) else {
            // If we can't load the size, or the font, CRASH. Something's wrong...
            fatalError()
        }
        return font
    }
    
    static func loadFonts() {
        // Register fonts to app, without using the Info.plist.... :smiling_imp:
        if let fontURLs = Bundle.main.urls(forResourcesWithExtension: "ttf", subdirectory: nil) {
            if #available(iOS 13.0, *) {
                CTFontManagerRegisterFontURLs(fontURLs as CFArray, .process, true, nil)
            } else {
                CTFontManagerRegisterFontsForURLs(fontURLs as CFArray, .process, nil)
            }
        }
    }
}

extension AppFont {
    enum DynamicType: String {
        case largeTitle = "UICTFontTextStyleLargeTitle"
        case title1 = "UICTFontTextStyleTitle1"
        case title2 = "UICTFontTextStyleTitle2"
        case title3 = "UICTFontTextStyleTitle3"
        case headline = "UICTFontTextStyleHeadline"
        case body = "UICTFontTextStyleBody"
        case callout = "UICTFontTextStyleCallout"
        case subheadline = "UICTFontTextStyleSubheadline"
        case subheadline1 = "UICTFontTextStyleSubheadline1"
        case footnote = "UICTFontTextStyleFootnote"
        case caption1 = "UICTFontTextStyleCaption1"
        case caption2 = "UICTFontTextStyleCaption2"
        case smallText = "UICTFontTextStylesmallText"
    }
    
    private var fontSizes: [DynamicType: CGFloat] {
        [
            .largeTitle: 34,
            .title1: 28,
            .title2: 22,
            .title3: 20,
            .headline: 18,
            .body: 17,
            .callout: 16,
            .subheadline: 15,
            .subheadline1: 14,
            .footnote: 13,
            .caption1: 12,
            .caption2: 11,
            .smallText: 10
        ]
    }
}
