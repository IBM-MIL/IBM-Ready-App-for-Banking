/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit

//Project specific font
extension UIFont {
    /**
    Returns the UIFont for Tuffy of a particular size
    :param: size The size of the font
    */
    class func tuffy(size: CGFloat) -> UIFont{return UIFont(name: "Tuffy", size: size)!}
    
    /**
    Returns the UIFont for Tuffy-Italic of a particular size
    :param: size The size of the font
    */
    class func tuffyItalic(size: CGFloat) -> UIFont{return UIFont(name: "Tuffy-Italic", size: size)!}
    
    /**
    Returns the UIFont for Tuffy-Bold-Italic of a particular size
    :param: size The size of the font
    */
    class func tuffyBoldItalic(size: CGFloat) -> UIFont{return UIFont(name: "Tuffy-Bold-Italic", size: size)!}
    
    /**
    Returns the UIFont for Tuffy-Bold of a particular size
    :param: size The size of the font
    */
    class func tuffyBold(size: CGFloat) -> UIFont{return UIFont(name: "Tuffy-Bold", size: size)!}
}

extension UIFont {
    
    
    /**
    Prints all the font names for the app to the console. This is helpful to find out if the font you added is in the project and to find the string needed to initialize a font with.
    */
    class func printAllFontNames(){
        for family in UIFont.familyNames(){
            println(family)
            for font in UIFont.fontNamesForFamilyName((family as! String)){
                println("\t\(font)")
            }
        }
    }
    
    /**
    Generates and prints all the code needed to make a function for each default font in XCode
    */
    class func printAllFontNameFunctions(){
        for family in UIFont.familyNames(){
            for font in (UIFont.fontNamesForFamilyName((family as! String)) as! [String]){
                var fontfunctionname = font.lowercaseFirstLetterString()
                fontfunctionname = fontfunctionname.stringByReplacingOccurrencesOfString("-", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                println("\t/**\n\tReturns the UIFont for \(font) of a particular size\n\t:param: size The size of the font\n\t*/\n\tclass func \(fontfunctionname)(size: CGFloat) -> UIFont{return UIFont(name: \"\(font)\", size: size)!}\n\n")
            }
        }
    }

    /**
    Returns the UIFont for Marion-Italic of a particular size
    :param: size The size of the font
    */
    class func marionItalic(size: CGFloat) -> UIFont{return UIFont(name: "Marion-Italic", size: size)!}
    
    
    /**
    Returns the UIFont for Marion-Bold of a particular size
    :param: size The size of the font
    */
    class func marionBold(size: CGFloat) -> UIFont{return UIFont(name: "Marion-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for Marion-Regular of a particular size
    :param: size The size of the font
    */
    class func marionRegular(size: CGFloat) -> UIFont{return UIFont(name: "Marion-Regular", size: size)!}
    
    
    /**
    Returns the UIFont for Copperplate-Light of a particular size
    :param: size The size of the font
    */
    class func copperplateLight(size: CGFloat) -> UIFont{return UIFont(name: "Copperplate-Light", size: size)!}
    
    
    /**
    Returns the UIFont for Copperplate of a particular size
    :param: size The size of the font
    */
    class func copperplate(size: CGFloat) -> UIFont{return UIFont(name: "Copperplate", size: size)!}
    
    
    /**
    Returns the UIFont for Copperplate-Bold of a particular size
    :param: size The size of the font
    */
    class func copperplateBold(size: CGFloat) -> UIFont{return UIFont(name: "Copperplate-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for STHeitiSC-Medium of a particular size
    :param: size The size of the font
    */
    class func sTHeitiSCMedium(size: CGFloat) -> UIFont{return UIFont(name: "STHeitiSC-Medium", size: size)!}
    
    
    /**
    Returns the UIFont for STHeitiSC-Light of a particular size
    :param: size The size of the font
    */
    class func sTHeitiSCLight(size: CGFloat) -> UIFont{return UIFont(name: "STHeitiSC-Light", size: size)!}
    
    
    /**
    Returns the UIFont for IowanOldStyle-Italic of a particular size
    :param: size The size of the font
    */
    class func iowanOldStyleItalic(size: CGFloat) -> UIFont{return UIFont(name: "IowanOldStyle-Italic", size: size)!}
    
    
    /**
    Returns the UIFont for IowanOldStyle-Roman of a particular size
    :param: size The size of the font
    */
    class func iowanOldStyleRoman(size: CGFloat) -> UIFont{return UIFont(name: "IowanOldStyle-Roman", size: size)!}
    
    
    /**
    Returns the UIFont for IowanOldStyle-BoldItalic of a particular size
    :param: size The size of the font
    */
    class func iowanOldStyleBoldItalic(size: CGFloat) -> UIFont{return UIFont(name: "IowanOldStyle-BoldItalic", size: size)!}
    
    
    /**
    Returns the UIFont for IowanOldStyle-Bold of a particular size
    :param: size The size of the font
    */
    class func iowanOldStyleBold(size: CGFloat) -> UIFont{return UIFont(name: "IowanOldStyle-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for CourierNewPS-BoldMT of a particular size
    :param: size The size of the font
    */
    class func courierNewPSBoldMT(size: CGFloat) -> UIFont{return UIFont(name: "CourierNewPS-BoldMT", size: size)!}
    
    
    /**
    Returns the UIFont for CourierNewPS-ItalicMT of a particular size
    :param: size The size of the font
    */
    class func courierNewPSItalicMT(size: CGFloat) -> UIFont{return UIFont(name: "CourierNewPS-ItalicMT", size: size)!}
    
    
    /**
    Returns the UIFont for CourierNewPSMT of a particular size
    :param: size The size of the font
    */
    class func courierNewPSMT(size: CGFloat) -> UIFont{return UIFont(name: "CourierNewPSMT", size: size)!}
    
    
    /**
    Returns the UIFont for CourierNewPS-BoldItalicMT of a particular size
    :param: size The size of the font
    */
    class func courierNewPSBoldItalicMT(size: CGFloat) -> UIFont{return UIFont(name: "CourierNewPS-BoldItalicMT", size: size)!}
    
    
    /**
    Returns the UIFont for AppleSDGothicNeo-Bold of a particular size
    :param: size The size of the font
    */
    class func appleSDGothicNeoBold(size: CGFloat) -> UIFont{return UIFont(name: "AppleSDGothicNeo-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for AppleSDGothicNeo-Thin of a particular size
    :param: size The size of the font
    */
    class func appleSDGothicNeoThin(size: CGFloat) -> UIFont{return UIFont(name: "AppleSDGothicNeo-Thin", size: size)!}
    
    
    /**
    Returns the UIFont for AppleSDGothicNeo-UltraLight of a particular size
    :param: size The size of the font
    */
    class func appleSDGothicNeoUltraLight(size: CGFloat) -> UIFont{return UIFont(name: "AppleSDGothicNeo-UltraLight", size: size)!}
    
    
    /**
    Returns the UIFont for AppleSDGothicNeo-Regular of a particular size
    :param: size The size of the font
    */
    class func appleSDGothicNeoRegular(size: CGFloat) -> UIFont{return UIFont(name: "AppleSDGothicNeo-Regular", size: size)!}
    
    
    /**
    Returns the UIFont for AppleSDGothicNeo-Light of a particular size
    :param: size The size of the font
    */
    class func appleSDGothicNeoLight(size: CGFloat) -> UIFont{return UIFont(name: "AppleSDGothicNeo-Light", size: size)!}
    
    
    /**
    Returns the UIFont for AppleSDGothicNeo-Medium of a particular size
    :param: size The size of the font
    */
    class func appleSDGothicNeoMedium(size: CGFloat) -> UIFont{return UIFont(name: "AppleSDGothicNeo-Medium", size: size)!}
    
    
    /**
    Returns the UIFont for AppleSDGothicNeo-SemiBold of a particular size
    :param: size The size of the font
    */
    class func appleSDGothicNeoSemiBold(size: CGFloat) -> UIFont{return UIFont(name: "AppleSDGothicNeo-SemiBold", size: size)!}
    
    
    /**
    Returns the UIFont for STHeitiTC-Medium of a particular size
    :param: size The size of the font
    */
    class func sTHeitiTCMedium(size: CGFloat) -> UIFont{return UIFont(name: "STHeitiTC-Medium", size: size)!}
    
    
    /**
    Returns the UIFont for STHeitiTC-Light of a particular size
    :param: size The size of the font
    */
    class func sTHeitiTCLight(size: CGFloat) -> UIFont{return UIFont(name: "STHeitiTC-Light", size: size)!}
    
    
    /**
    Returns the UIFont for GillSans-Italic of a particular size
    :param: size The size of the font
    */
    class func gillSansItalic(size: CGFloat) -> UIFont{return UIFont(name: "GillSans-Italic", size: size)!}
    
    
    /**
    Returns the UIFont for GillSans-Bold of a particular size
    :param: size The size of the font
    */
    class func gillSansBold(size: CGFloat) -> UIFont{return UIFont(name: "GillSans-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for GillSans-BoldItalic of a particular size
    :param: size The size of the font
    */
    class func gillSansBoldItalic(size: CGFloat) -> UIFont{return UIFont(name: "GillSans-BoldItalic", size: size)!}
    
    
    /**
    Returns the UIFont for GillSans-LightItalic of a particular size
    :param: size The size of the font
    */
    class func gillSansLightItalic(size: CGFloat) -> UIFont{return UIFont(name: "GillSans-LightItalic", size: size)!}
    
    
    /**
    Returns the UIFont for GillSans of a particular size
    :param: size The size of the font
    */
    class func gillSans(size: CGFloat) -> UIFont{return UIFont(name: "GillSans", size: size)!}
    
    
    /**
    Returns the UIFont for GillSans-Light of a particular size
    :param: size The size of the font
    */
    class func gillSansLight(size: CGFloat) -> UIFont{return UIFont(name: "GillSans-Light", size: size)!}
    
    
    /**
    Returns the UIFont for MarkerFelt-Thin of a particular size
    :param: size The size of the font
    */
    class func markerFeltThin(size: CGFloat) -> UIFont{return UIFont(name: "MarkerFelt-Thin", size: size)!}
    
    
    /**
    Returns the UIFont for MarkerFelt-Wide of a particular size
    :param: size The size of the font
    */
    class func markerFeltWide(size: CGFloat) -> UIFont{return UIFont(name: "MarkerFelt-Wide", size: size)!}
    
    
    /**
    Returns the UIFont for Thonburi of a particular size
    :param: size The size of the font
    */
    class func thonburi(size: CGFloat) -> UIFont{return UIFont(name: "Thonburi", size: size)!}
    
    
    /**
    Returns the UIFont for Thonburi-Bold of a particular size
    :param: size The size of the font
    */
    class func thonburiBold(size: CGFloat) -> UIFont{return UIFont(name: "Thonburi-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for Thonburi-Light of a particular size
    :param: size The size of the font
    */
    class func thonburiLight(size: CGFloat) -> UIFont{return UIFont(name: "Thonburi-Light", size: size)!}
    
    
    /**
    Returns the UIFont for AvenirNextCondensed-BoldItalic of a particular size
    :param: size The size of the font
    */
    class func avenirNextCondensedBoldItalic(size: CGFloat) -> UIFont{return UIFont(name: "AvenirNextCondensed-BoldItalic", size: size)!}
    
    
    /**
    Returns the UIFont for AvenirNextCondensed-Heavy of a particular size
    :param: size The size of the font
    */
    class func avenirNextCondensedHeavy(size: CGFloat) -> UIFont{return UIFont(name: "AvenirNextCondensed-Heavy", size: size)!}
    
    
    /**
    Returns the UIFont for AvenirNextCondensed-Medium of a particular size
    :param: size The size of the font
    */
    class func avenirNextCondensedMedium(size: CGFloat) -> UIFont{return UIFont(name: "AvenirNextCondensed-Medium", size: size)!}
    
    
    /**
    Returns the UIFont for AvenirNextCondensed-Regular of a particular size
    :param: size The size of the font
    */
    class func avenirNextCondensedRegular(size: CGFloat) -> UIFont{return UIFont(name: "AvenirNextCondensed-Regular", size: size)!}
    
    
    /**
    Returns the UIFont for AvenirNextCondensed-HeavyItalic of a particular size
    :param: size The size of the font
    */
    class func avenirNextCondensedHeavyItalic(size: CGFloat) -> UIFont{return UIFont(name: "AvenirNextCondensed-HeavyItalic", size: size)!}
    
    
    /**
    Returns the UIFont for AvenirNextCondensed-MediumItalic of a particular size
    :param: size The size of the font
    */
    class func avenirNextCondensedMediumItalic(size: CGFloat) -> UIFont{return UIFont(name: "AvenirNextCondensed-MediumItalic", size: size)!}
    
    
    /**
    Returns the UIFont for AvenirNextCondensed-Italic of a particular size
    :param: size The size of the font
    */
    class func avenirNextCondensedItalic(size: CGFloat) -> UIFont{return UIFont(name: "AvenirNextCondensed-Italic", size: size)!}
    
    
    /**
    Returns the UIFont for AvenirNextCondensed-UltraLightItalic of a particular size
    :param: size The size of the font
    */
    class func avenirNextCondensedUltraLightItalic(size: CGFloat) -> UIFont{return UIFont(name: "AvenirNextCondensed-UltraLightItalic", size: size)!}
    
    
    /**
    Returns the UIFont for AvenirNextCondensed-UltraLight of a particular size
    :param: size The size of the font
    */
    class func avenirNextCondensedUltraLight(size: CGFloat) -> UIFont{return UIFont(name: "AvenirNextCondensed-UltraLight", size: size)!}
    
    
    /**
    Returns the UIFont for AvenirNextCondensed-DemiBold of a particular size
    :param: size The size of the font
    */
    class func avenirNextCondensedDemiBold(size: CGFloat) -> UIFont{return UIFont(name: "AvenirNextCondensed-DemiBold", size: size)!}
    
    
    /**
    Returns the UIFont for AvenirNextCondensed-Bold of a particular size
    :param: size The size of the font
    */
    class func avenirNextCondensedBold(size: CGFloat) -> UIFont{return UIFont(name: "AvenirNextCondensed-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for AvenirNextCondensed-DemiBoldItalic of a particular size
    :param: size The size of the font
    */
    class func avenirNextCondensedDemiBoldItalic(size: CGFloat) -> UIFont{return UIFont(name: "AvenirNextCondensed-DemiBoldItalic", size: size)!}
    
    
    /**
    Returns the UIFont for TamilSangamMN of a particular size
    :param: size The size of the font
    */
    class func tamilSangamMN(size: CGFloat) -> UIFont{return UIFont(name: "TamilSangamMN", size: size)!}
    
    
    /**
    Returns the UIFont for TamilSangamMN-Bold of a particular size
    :param: size The size of the font
    */
    class func tamilSangamMNBold(size: CGFloat) -> UIFont{return UIFont(name: "TamilSangamMN-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for HelveticaNeue-Italic of a particular size
    :param: size The size of the font
    */
    class func helveticaNeueItalic(size: CGFloat) -> UIFont{return UIFont(name: "HelveticaNeue-Italic", size: size)!}
    
    
    /**
    Returns the UIFont for HelveticaNeue-Bold of a particular size
    :param: size The size of the font
    */
    class func helveticaNeueBold(size: CGFloat) -> UIFont{return UIFont(name: "HelveticaNeue-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for HelveticaNeue-UltraLight of a particular size
    :param: size The size of the font
    */
    class func helveticaNeueUltraLight(size: CGFloat) -> UIFont{return UIFont(name: "HelveticaNeue-UltraLight", size: size)!}
    
    
    /**
    Returns the UIFont for HelveticaNeue-CondensedBlack of a particular size
    :param: size The size of the font
    */
    class func helveticaNeueCondensedBlack(size: CGFloat) -> UIFont{return UIFont(name: "HelveticaNeue-CondensedBlack", size: size)!}
    
    
    /**
    Returns the UIFont for HelveticaNeue-BoldItalic of a particular size
    :param: size The size of the font
    */
    class func helveticaNeueBoldItalic(size: CGFloat) -> UIFont{return UIFont(name: "HelveticaNeue-BoldItalic", size: size)!}
    
    
    /**
    Returns the UIFont for HelveticaNeue-CondensedBold of a particular size
    :param: size The size of the font
    */
    class func helveticaNeueCondensedBold(size: CGFloat) -> UIFont{return UIFont(name: "HelveticaNeue-CondensedBold", size: size)!}
    
    
    /**
    Returns the UIFont for HelveticaNeue-Medium of a particular size
    :param: size The size of the font
    */
    class func helveticaNeueMedium(size: CGFloat) -> UIFont{return UIFont(name: "HelveticaNeue-Medium", size: size)!}
    
    
    /**
    Returns the UIFont for HelveticaNeue-Light of a particular size
    :param: size The size of the font
    */
    class func helveticaNeueLight(size: CGFloat) -> UIFont{return UIFont(name: "HelveticaNeue-Light", size: size)!}
    
    
    /**
    Returns the UIFont for HelveticaNeue-Thin of a particular size
    :param: size The size of the font
    */
    class func helveticaNeueThin(size: CGFloat) -> UIFont{return UIFont(name: "HelveticaNeue-Thin", size: size)!}
    
    
    /**
    Returns the UIFont for HelveticaNeue-ThinItalic of a particular size
    :param: size The size of the font
    */
    class func helveticaNeueThinItalic(size: CGFloat) -> UIFont{return UIFont(name: "HelveticaNeue-ThinItalic", size: size)!}
    
    
    /**
    Returns the UIFont for HelveticaNeue-LightItalic of a particular size
    :param: size The size of the font
    */
    class func helveticaNeueLightItalic(size: CGFloat) -> UIFont{return UIFont(name: "HelveticaNeue-LightItalic", size: size)!}
    
    
    /**
    Returns the UIFont for HelveticaNeue-UltraLightItalic of a particular size
    :param: size The size of the font
    */
    class func helveticaNeueUltraLightItalic(size: CGFloat) -> UIFont{return UIFont(name: "HelveticaNeue-UltraLightItalic", size: size)!}
    
    
    /**
    Returns the UIFont for HelveticaNeue-MediumItalic of a particular size
    :param: size The size of the font
    */
    class func helveticaNeueMediumItalic(size: CGFloat) -> UIFont{return UIFont(name: "HelveticaNeue-MediumItalic", size: size)!}
    
    
    /**
    Returns the UIFont for HelveticaNeue of a particular size
    :param: size The size of the font
    */
    class func helveticaNeue(size: CGFloat) -> UIFont{return UIFont(name: "HelveticaNeue", size: size)!}
    
    
    /**
    Returns the UIFont for GurmukhiMN-Bold of a particular size
    :param: size The size of the font
    */
    class func gurmukhiMNBold(size: CGFloat) -> UIFont{return UIFont(name: "GurmukhiMN-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for GurmukhiMN of a particular size
    :param: size The size of the font
    */
    class func gurmukhiMN(size: CGFloat) -> UIFont{return UIFont(name: "GurmukhiMN", size: size)!}
    
    
    /**
    Returns the UIFont for TimesNewRomanPSMT of a particular size
    :param: size The size of the font
    */
    class func timesNewRomanPSMT(size: CGFloat) -> UIFont{return UIFont(name: "TimesNewRomanPSMT", size: size)!}
    
    
    /**
    Returns the UIFont for TimesNewRomanPS-BoldItalicMT of a particular size
    :param: size The size of the font
    */
    class func timesNewRomanPSBoldItalicMT(size: CGFloat) -> UIFont{return UIFont(name: "TimesNewRomanPS-BoldItalicMT", size: size)!}
    
    
    /**
    Returns the UIFont for TimesNewRomanPS-ItalicMT of a particular size
    :param: size The size of the font
    */
    class func timesNewRomanPSItalicMT(size: CGFloat) -> UIFont{return UIFont(name: "TimesNewRomanPS-ItalicMT", size: size)!}
    
    
    /**
    Returns the UIFont for TimesNewRomanPS-BoldMT of a particular size
    :param: size The size of the font
    */
    class func timesNewRomanPSBoldMT(size: CGFloat) -> UIFont{return UIFont(name: "TimesNewRomanPS-BoldMT", size: size)!}
    
    
    /**
    Returns the UIFont for Georgia-BoldItalic of a particular size
    :param: size The size of the font
    */
    class func georgiaBoldItalic(size: CGFloat) -> UIFont{return UIFont(name: "Georgia-BoldItalic", size: size)!}
    
    
    /**
    Returns the UIFont for Georgia of a particular size
    :param: size The size of the font
    */
    class func georgia(size: CGFloat) -> UIFont{return UIFont(name: "Georgia", size: size)!}
    
    
    /**
    Returns the UIFont for Georgia-Italic of a particular size
    :param: size The size of the font
    */
    class func georgiaItalic(size: CGFloat) -> UIFont{return UIFont(name: "Georgia-Italic", size: size)!}
    
    
    /**
    Returns the UIFont for Georgia-Bold of a particular size
    :param: size The size of the font
    */
    class func georgiaBold(size: CGFloat) -> UIFont{return UIFont(name: "Georgia-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for AppleColorEmoji of a particular size
    :param: size The size of the font
    */
    class func appleColorEmoji(size: CGFloat) -> UIFont{return UIFont(name: "AppleColorEmoji", size: size)!}
    
    
    /**
    Returns the UIFont for ArialRoundedMTBold of a particular size
    :param: size The size of the font
    */
    class func arialRoundedMTBold(size: CGFloat) -> UIFont{return UIFont(name: "ArialRoundedMTBold", size: size)!}
    
    
    /**
    Returns the UIFont for Kailasa-Bold of a particular size
    :param: size The size of the font
    */
    class func kailasaBold(size: CGFloat) -> UIFont{return UIFont(name: "Kailasa-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for Kailasa of a particular size
    :param: size The size of the font
    */
    class func kailasa(size: CGFloat) -> UIFont{return UIFont(name: "Kailasa", size: size)!}
    
    
    /**
    Returns the UIFont for KohinoorDevanagari-Light of a particular size
    :param: size The size of the font
    */
    class func kohinoorDevanagariLight(size: CGFloat) -> UIFont{return UIFont(name: "KohinoorDevanagari-Light", size: size)!}
    
    
    /**
    Returns the UIFont for KohinoorDevanagari-Medium of a particular size
    :param: size The size of the font
    */
    class func kohinoorDevanagariMedium(size: CGFloat) -> UIFont{return UIFont(name: "KohinoorDevanagari-Medium", size: size)!}
    
    
    /**
    Returns the UIFont for KohinoorDevanagari-Book of a particular size
    :param: size The size of the font
    */
    class func kohinoorDevanagariBook(size: CGFloat) -> UIFont{return UIFont(name: "KohinoorDevanagari-Book", size: size)!}
    
    
    /**
    Returns the UIFont for SinhalaSangamMN-Bold of a particular size
    :param: size The size of the font
    */
    class func sinhalaSangamMNBold(size: CGFloat) -> UIFont{return UIFont(name: "SinhalaSangamMN-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for SinhalaSangamMN of a particular size
    :param: size The size of the font
    */
    class func sinhalaSangamMN(size: CGFloat) -> UIFont{return UIFont(name: "SinhalaSangamMN", size: size)!}
    
    
    /**
    Returns the UIFont for ChalkboardSE-Bold of a particular size
    :param: size The size of the font
    */
    class func chalkboardSEBold(size: CGFloat) -> UIFont{return UIFont(name: "ChalkboardSE-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for ChalkboardSE-Light of a particular size
    :param: size The size of the font
    */
    class func chalkboardSELight(size: CGFloat) -> UIFont{return UIFont(name: "ChalkboardSE-Light", size: size)!}
    
    
    /**
    Returns the UIFont for ChalkboardSE-Regular of a particular size
    :param: size The size of the font
    */
    class func chalkboardSERegular(size: CGFloat) -> UIFont{return UIFont(name: "ChalkboardSE-Regular", size: size)!}
    
    
    /**
    Returns the UIFont for Superclarendon-Italic of a particular size
    :param: size The size of the font
    */
    class func superclarendonItalic(size: CGFloat) -> UIFont{return UIFont(name: "Superclarendon-Italic", size: size)!}
    
    
    /**
    Returns the UIFont for Superclarendon-Black of a particular size
    :param: size The size of the font
    */
    class func superclarendonBlack(size: CGFloat) -> UIFont{return UIFont(name: "Superclarendon-Black", size: size)!}
    
    
    /**
    Returns the UIFont for Superclarendon-LightItalic of a particular size
    :param: size The size of the font
    */
    class func superclarendonLightItalic(size: CGFloat) -> UIFont{return UIFont(name: "Superclarendon-LightItalic", size: size)!}
    
    
    /**
    Returns the UIFont for Superclarendon-BlackItalic of a particular size
    :param: size The size of the font
    */
    class func superclarendonBlackItalic(size: CGFloat) -> UIFont{return UIFont(name: "Superclarendon-BlackItalic", size: size)!}
    
    
    /**
    Returns the UIFont for Superclarendon-BoldItalic of a particular size
    :param: size The size of the font
    */
    class func superclarendonBoldItalic(size: CGFloat) -> UIFont{return UIFont(name: "Superclarendon-BoldItalic", size: size)!}
    
    
    /**
    Returns the UIFont for Superclarendon-Light of a particular size
    :param: size The size of the font
    */
    class func superclarendonLight(size: CGFloat) -> UIFont{return UIFont(name: "Superclarendon-Light", size: size)!}
    
    
    /**
    Returns the UIFont for Superclarendon-Regular of a particular size
    :param: size The size of the font
    */
    class func superclarendonRegular(size: CGFloat) -> UIFont{return UIFont(name: "Superclarendon-Regular", size: size)!}
    
    
    /**
    Returns the UIFont for Superclarendon-Bold of a particular size
    :param: size The size of the font
    */
    class func superclarendonBold(size: CGFloat) -> UIFont{return UIFont(name: "Superclarendon-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for GujaratiSangamMN-Bold of a particular size
    :param: size The size of the font
    */
    class func gujaratiSangamMNBold(size: CGFloat) -> UIFont{return UIFont(name: "GujaratiSangamMN-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for GujaratiSangamMN of a particular size
    :param: size The size of the font
    */
    class func gujaratiSangamMN(size: CGFloat) -> UIFont{return UIFont(name: "GujaratiSangamMN", size: size)!}
    
    
    /**
    Returns the UIFont for DamascusLight of a particular size
    :param: size The size of the font
    */
    class func damascusLight(size: CGFloat) -> UIFont{return UIFont(name: "DamascusLight", size: size)!}
    
    
    /**
    Returns the UIFont for DamascusBold of a particular size
    :param: size The size of the font
    */
    class func damascusBold(size: CGFloat) -> UIFont{return UIFont(name: "DamascusBold", size: size)!}
    
    
    /**
    Returns the UIFont for DamascusSemiBold of a particular size
    :param: size The size of the font
    */
    class func damascusSemiBold(size: CGFloat) -> UIFont{return UIFont(name: "DamascusSemiBold", size: size)!}
    
    
    /**
    Returns the UIFont for DamascusMedium of a particular size
    :param: size The size of the font
    */
    class func damascusMedium(size: CGFloat) -> UIFont{return UIFont(name: "DamascusMedium", size: size)!}
    
    
    /**
    Returns the UIFont for Damascus of a particular size
    :param: size The size of the font
    */
    class func damascus(size: CGFloat) -> UIFont{return UIFont(name: "Damascus", size: size)!}
    
    
    /**
    Returns the UIFont for Noteworthy-Light of a particular size
    :param: size The size of the font
    */
    class func noteworthyLight(size: CGFloat) -> UIFont{return UIFont(name: "Noteworthy-Light", size: size)!}
    
    
    /**
    Returns the UIFont for Noteworthy-Bold of a particular size
    :param: size The size of the font
    */
    class func noteworthyBold(size: CGFloat) -> UIFont{return UIFont(name: "Noteworthy-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for GeezaPro of a particular size
    :param: size The size of the font
    */
    class func geezaPro(size: CGFloat) -> UIFont{return UIFont(name: "GeezaPro", size: size)!}
    
    
    /**
    Returns the UIFont for GeezaPro-Bold of a particular size
    :param: size The size of the font
    */
    class func geezaProBold(size: CGFloat) -> UIFont{return UIFont(name: "GeezaPro-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for Avenir-Medium of a particular size
    :param: size The size of the font
    */
    class func avenirMedium(size: CGFloat) -> UIFont{return UIFont(name: "Avenir-Medium", size: size)!}
    
    
    /**
    Returns the UIFont for Avenir-HeavyOblique of a particular size
    :param: size The size of the font
    */
    class func avenirHeavyOblique(size: CGFloat) -> UIFont{return UIFont(name: "Avenir-HeavyOblique", size: size)!}
    
    
    /**
    Returns the UIFont for Avenir-Book of a particular size
    :param: size The size of the font
    */
    class func avenirBook(size: CGFloat) -> UIFont{return UIFont(name: "Avenir-Book", size: size)!}
    
    
    /**
    Returns the UIFont for Avenir-Light of a particular size
    :param: size The size of the font
    */
    class func avenirLight(size: CGFloat) -> UIFont{return UIFont(name: "Avenir-Light", size: size)!}
    
    
    /**
    Returns the UIFont for Avenir-Roman of a particular size
    :param: size The size of the font
    */
    class func avenirRoman(size: CGFloat) -> UIFont{return UIFont(name: "Avenir-Roman", size: size)!}
    
    
    /**
    Returns the UIFont for Avenir-BookOblique of a particular size
    :param: size The size of the font
    */
    class func avenirBookOblique(size: CGFloat) -> UIFont{return UIFont(name: "Avenir-BookOblique", size: size)!}
    
    
    /**
    Returns the UIFont for Avenir-Black of a particular size
    :param: size The size of the font
    */
    class func avenirBlack(size: CGFloat) -> UIFont{return UIFont(name: "Avenir-Black", size: size)!}
    
    
    /**
    Returns the UIFont for Avenir-MediumOblique of a particular size
    :param: size The size of the font
    */
    class func avenirMediumOblique(size: CGFloat) -> UIFont{return UIFont(name: "Avenir-MediumOblique", size: size)!}
    
    
    /**
    Returns the UIFont for Avenir-BlackOblique of a particular size
    :param: size The size of the font
    */
    class func avenirBlackOblique(size: CGFloat) -> UIFont{return UIFont(name: "Avenir-BlackOblique", size: size)!}
    
    
    /**
    Returns the UIFont for Avenir-Heavy of a particular size
    :param: size The size of the font
    */
    class func avenirHeavy(size: CGFloat) -> UIFont{return UIFont(name: "Avenir-Heavy", size: size)!}
    
    
    /**
    Returns the UIFont for Avenir-LightOblique of a particular size
    :param: size The size of the font
    */
    class func avenirLightOblique(size: CGFloat) -> UIFont{return UIFont(name: "Avenir-LightOblique", size: size)!}
    
    
    /**
    Returns the UIFont for Avenir-Oblique of a particular size
    :param: size The size of the font
    */
    class func avenirOblique(size: CGFloat) -> UIFont{return UIFont(name: "Avenir-Oblique", size: size)!}
    
    
    /**
    Returns the UIFont for AcademyEngravedLetPlain of a particular size
    :param: size The size of the font
    */
    class func academyEngravedLetPlain(size: CGFloat) -> UIFont{return UIFont(name: "AcademyEngravedLetPlain", size: size)!}
    
    
    /**
    Returns the UIFont for DiwanMishafi of a particular size
    :param: size The size of the font
    */
    class func diwanMishafi(size: CGFloat) -> UIFont{return UIFont(name: "DiwanMishafi", size: size)!}
    
    
    /**
    Returns the UIFont for Futura-CondensedMedium of a particular size
    :param: size The size of the font
    */
    class func futuraCondensedMedium(size: CGFloat) -> UIFont{return UIFont(name: "Futura-CondensedMedium", size: size)!}
    
    
    /**
    Returns the UIFont for Futura-CondensedExtraBold of a particular size
    :param: size The size of the font
    */
    class func futuraCondensedExtraBold(size: CGFloat) -> UIFont{return UIFont(name: "Futura-CondensedExtraBold", size: size)!}
    
    
    /**
    Returns the UIFont for Futura-Medium of a particular size
    :param: size The size of the font
    */
    class func futuraMedium(size: CGFloat) -> UIFont{return UIFont(name: "Futura-Medium", size: size)!}
    
    
    /**
    Returns the UIFont for Futura-MediumItalic of a particular size
    :param: size The size of the font
    */
    class func futuraMediumItalic(size: CGFloat) -> UIFont{return UIFont(name: "Futura-MediumItalic", size: size)!}
    
    
    /**
    Returns the UIFont for Farah of a particular size
    :param: size The size of the font
    */
    class func farah(size: CGFloat) -> UIFont{return UIFont(name: "Farah", size: size)!}
    
    
    /**
    Returns the UIFont for KannadaSangamMN of a particular size
    :param: size The size of the font
    */
    class func kannadaSangamMN(size: CGFloat) -> UIFont{return UIFont(name: "KannadaSangamMN", size: size)!}
    
    
    /**
    Returns the UIFont for KannadaSangamMN-Bold of a particular size
    :param: size The size of the font
    */
    class func kannadaSangamMNBold(size: CGFloat) -> UIFont{return UIFont(name: "KannadaSangamMN-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for ArialHebrew-Bold of a particular size
    :param: size The size of the font
    */
    class func arialHebrewBold(size: CGFloat) -> UIFont{return UIFont(name: "ArialHebrew-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for ArialHebrew-Light of a particular size
    :param: size The size of the font
    */
    class func arialHebrewLight(size: CGFloat) -> UIFont{return UIFont(name: "ArialHebrew-Light", size: size)!}
    
    
    /**
    Returns the UIFont for ArialHebrew of a particular size
    :param: size The size of the font
    */
    class func arialHebrew(size: CGFloat) -> UIFont{return UIFont(name: "ArialHebrew", size: size)!}
    
    
    /**
    Returns the UIFont for ArialMT of a particular size
    :param: size The size of the font
    */
    class func arialMT(size: CGFloat) -> UIFont{return UIFont(name: "ArialMT", size: size)!}
    
    
    /**
    Returns the UIFont for Arial-BoldItalicMT of a particular size
    :param: size The size of the font
    */
    class func arialBoldItalicMT(size: CGFloat) -> UIFont{return UIFont(name: "Arial-BoldItalicMT", size: size)!}
    
    
    /**
    Returns the UIFont for Arial-BoldMT of a particular size
    :param: size The size of the font
    */
    class func arialBoldMT(size: CGFloat) -> UIFont{return UIFont(name: "Arial-BoldMT", size: size)!}
    
    
    /**
    Returns the UIFont for Arial-ItalicMT of a particular size
    :param: size The size of the font
    */
    class func arialItalicMT(size: CGFloat) -> UIFont{return UIFont(name: "Arial-ItalicMT", size: size)!}
    
    
    /**
    Returns the UIFont for PartyLetPlain of a particular size
    :param: size The size of the font
    */
    class func partyLetPlain(size: CGFloat) -> UIFont{return UIFont(name: "PartyLetPlain", size: size)!}
    
    
    /**
    Returns the UIFont for Chalkduster of a particular size
    :param: size The size of the font
    */
    class func chalkduster(size: CGFloat) -> UIFont{return UIFont(name: "Chalkduster", size: size)!}
    
    
    /**
    Returns the UIFont for HiraKakuProN-W6 of a particular size
    :param: size The size of the font
    */
    class func hiraKakuProNW6(size: CGFloat) -> UIFont{return UIFont(name: "HiraKakuProN-W6", size: size)!}
    
    
    /**
    Returns the UIFont for HiraKakuProN-W3 of a particular size
    :param: size The size of the font
    */
    class func hiraKakuProNW3(size: CGFloat) -> UIFont{return UIFont(name: "HiraKakuProN-W3", size: size)!}
    
    
    /**
    Returns the UIFont for HoeflerText-Italic of a particular size
    :param: size The size of the font
    */
    class func hoeflerTextItalic(size: CGFloat) -> UIFont{return UIFont(name: "HoeflerText-Italic", size: size)!}
    
    
    /**
    Returns the UIFont for HoeflerText-Regular of a particular size
    :param: size The size of the font
    */
    class func hoeflerTextRegular(size: CGFloat) -> UIFont{return UIFont(name: "HoeflerText-Regular", size: size)!}
    
    
    /**
    Returns the UIFont for HoeflerText-Black of a particular size
    :param: size The size of the font
    */
    class func hoeflerTextBlack(size: CGFloat) -> UIFont{return UIFont(name: "HoeflerText-Black", size: size)!}
    
    
    /**
    Returns the UIFont for HoeflerText-BlackItalic of a particular size
    :param: size The size of the font
    */
    class func hoeflerTextBlackItalic(size: CGFloat) -> UIFont{return UIFont(name: "HoeflerText-BlackItalic", size: size)!}
    
    
    /**
    Returns the UIFont for Optima-Regular of a particular size
    :param: size The size of the font
    */
    class func optimaRegular(size: CGFloat) -> UIFont{return UIFont(name: "Optima-Regular", size: size)!}
    
    
    /**
    Returns the UIFont for Optima-ExtraBlack of a particular size
    :param: size The size of the font
    */
    class func optimaExtraBlack(size: CGFloat) -> UIFont{return UIFont(name: "Optima-ExtraBlack", size: size)!}
    
    
    /**
    Returns the UIFont for Optima-BoldItalic of a particular size
    :param: size The size of the font
    */
    class func optimaBoldItalic(size: CGFloat) -> UIFont{return UIFont(name: "Optima-BoldItalic", size: size)!}
    
    
    /**
    Returns the UIFont for Optima-Italic of a particular size
    :param: size The size of the font
    */
    class func optimaItalic(size: CGFloat) -> UIFont{return UIFont(name: "Optima-Italic", size: size)!}
    
    
    /**
    Returns the UIFont for Optima-Bold of a particular size
    :param: size The size of the font
    */
    class func optimaBold(size: CGFloat) -> UIFont{return UIFont(name: "Optima-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for Palatino-Bold of a particular size
    :param: size The size of the font
    */
    class func palatinoBold(size: CGFloat) -> UIFont{return UIFont(name: "Palatino-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for Palatino-Roman of a particular size
    :param: size The size of the font
    */
    class func palatinoRoman(size: CGFloat) -> UIFont{return UIFont(name: "Palatino-Roman", size: size)!}
    
    
    /**
    Returns the UIFont for Palatino-BoldItalic of a particular size
    :param: size The size of the font
    */
    class func palatinoBoldItalic(size: CGFloat) -> UIFont{return UIFont(name: "Palatino-BoldItalic", size: size)!}
    
    
    /**
    Returns the UIFont for Palatino-Italic of a particular size
    :param: size The size of the font
    */
    class func palatinoItalic(size: CGFloat) -> UIFont{return UIFont(name: "Palatino-Italic", size: size)!}
    
    
    /**
    Returns the UIFont for MalayalamSangamMN-Bold of a particular size
    :param: size The size of the font
    */
    class func malayalamSangamMNBold(size: CGFloat) -> UIFont{return UIFont(name: "MalayalamSangamMN-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for MalayalamSangamMN of a particular size
    :param: size The size of the font
    */
    class func malayalamSangamMN(size: CGFloat) -> UIFont{return UIFont(name: "MalayalamSangamMN", size: size)!}
    
    
    /**
    Returns the UIFont for LaoSangamMN of a particular size
    :param: size The size of the font
    */
    class func laoSangamMN(size: CGFloat) -> UIFont{return UIFont(name: "LaoSangamMN", size: size)!}
    
    
    /**
    Returns the UIFont for AlNile-Bold of a particular size
    :param: size The size of the font
    */
    class func alNileBold(size: CGFloat) -> UIFont{return UIFont(name: "AlNile-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for AlNile of a particular size
    :param: size The size of the font
    */
    class func alNile(size: CGFloat) -> UIFont{return UIFont(name: "AlNile", size: size)!}
    
    
    /**
    Returns the UIFont for BradleyHandITCTT-Bold of a particular size
    :param: size The size of the font
    */
    class func bradleyHandITCTTBold(size: CGFloat) -> UIFont{return UIFont(name: "BradleyHandITCTT-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for HiraMinProN-W6 of a particular size
    :param: size The size of the font
    */
    class func hiraMinProNW6(size: CGFloat) -> UIFont{return UIFont(name: "HiraMinProN-W6", size: size)!}
    
    
    /**
    Returns the UIFont for HiraMinProN-W3 of a particular size
    :param: size The size of the font
    */
    class func hiraMinProNW3(size: CGFloat) -> UIFont{return UIFont(name: "HiraMinProN-W3", size: size)!}
    
    
    /**
    Returns the UIFont for Trebuchet-BoldItalic of a particular size
    :param: size The size of the font
    */
    class func trebuchetBoldItalic(size: CGFloat) -> UIFont{return UIFont(name: "Trebuchet-BoldItalic", size: size)!}
    
    
    /**
    Returns the UIFont for TrebuchetMS of a particular size
    :param: size The size of the font
    */
    class func trebuchetMS(size: CGFloat) -> UIFont{return UIFont(name: "TrebuchetMS", size: size)!}
    
    
    /**
    Returns the UIFont for TrebuchetMS-Bold of a particular size
    :param: size The size of the font
    */
    class func trebuchetMSBold(size: CGFloat) -> UIFont{return UIFont(name: "TrebuchetMS-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for TrebuchetMS-Italic of a particular size
    :param: size The size of the font
    */
    class func trebuchetMSItalic(size: CGFloat) -> UIFont{return UIFont(name: "TrebuchetMS-Italic", size: size)!}
    
    
    /**
    Returns the UIFont for Helvetica-Bold of a particular size
    :param: size The size of the font
    */
    class func helveticaBold(size: CGFloat) -> UIFont{return UIFont(name: "Helvetica-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for Helvetica of a particular size
    :param: size The size of the font
    */
    class func helvetica(size: CGFloat) -> UIFont{return UIFont(name: "Helvetica", size: size)!}
    
    
    /**
    Returns the UIFont for Helvetica-LightOblique of a particular size
    :param: size The size of the font
    */
    class func helveticaLightOblique(size: CGFloat) -> UIFont{return UIFont(name: "Helvetica-LightOblique", size: size)!}
    
    
    /**
    Returns the UIFont for Helvetica-Oblique of a particular size
    :param: size The size of the font
    */
    class func helveticaOblique(size: CGFloat) -> UIFont{return UIFont(name: "Helvetica-Oblique", size: size)!}
    
    
    /**
    Returns the UIFont for Helvetica-BoldOblique of a particular size
    :param: size The size of the font
    */
    class func helveticaBoldOblique(size: CGFloat) -> UIFont{return UIFont(name: "Helvetica-BoldOblique", size: size)!}
    
    
    /**
    Returns the UIFont for Helvetica-Light of a particular size
    :param: size The size of the font
    */
    class func helveticaLight(size: CGFloat) -> UIFont{return UIFont(name: "Helvetica-Light", size: size)!}
    
    
    /**
    Returns the UIFont for Courier-BoldOblique of a particular size
    :param: size The size of the font
    */
    class func courierBoldOblique(size: CGFloat) -> UIFont{return UIFont(name: "Courier-BoldOblique", size: size)!}
    
    
    /**
    Returns the UIFont for Courier of a particular size
    :param: size The size of the font
    */
    class func courier(size: CGFloat) -> UIFont{return UIFont(name: "Courier", size: size)!}
    
    
    /**
    Returns the UIFont for Courier-Bold of a particular size
    :param: size The size of the font
    */
    class func courierBold(size: CGFloat) -> UIFont{return UIFont(name: "Courier-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for Courier-Oblique of a particular size
    :param: size The size of the font
    */
    class func courierOblique(size: CGFloat) -> UIFont{return UIFont(name: "Courier-Oblique", size: size)!}
    
    
    /**
    Returns the UIFont for Cochin-Bold of a particular size
    :param: size The size of the font
    */
    class func cochinBold(size: CGFloat) -> UIFont{return UIFont(name: "Cochin-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for Cochin of a particular size
    :param: size The size of the font
    */
    class func cochin(size: CGFloat) -> UIFont{return UIFont(name: "Cochin", size: size)!}
    
    
    /**
    Returns the UIFont for Cochin-Italic of a particular size
    :param: size The size of the font
    */
    class func cochinItalic(size: CGFloat) -> UIFont{return UIFont(name: "Cochin-Italic", size: size)!}
    
    
    /**
    Returns the UIFont for Cochin-BoldItalic of a particular size
    :param: size The size of the font
    */
    class func cochinBoldItalic(size: CGFloat) -> UIFont{return UIFont(name: "Cochin-BoldItalic", size: size)!}
    
    
    /**
    Returns the UIFont for DevanagariSangamMN of a particular size
    :param: size The size of the font
    */
    class func devanagariSangamMN(size: CGFloat) -> UIFont{return UIFont(name: "DevanagariSangamMN", size: size)!}
    
    
    /**
    Returns the UIFont for DevanagariSangamMN-Bold of a particular size
    :param: size The size of the font
    */
    class func devanagariSangamMNBold(size: CGFloat) -> UIFont{return UIFont(name: "DevanagariSangamMN-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for OriyaSangamMN of a particular size
    :param: size The size of the font
    */
    class func oriyaSangamMN(size: CGFloat) -> UIFont{return UIFont(name: "OriyaSangamMN", size: size)!}
    
    
    /**
    Returns the UIFont for OriyaSangamMN-Bold of a particular size
    :param: size The size of the font
    */
    class func oriyaSangamMNBold(size: CGFloat) -> UIFont{return UIFont(name: "OriyaSangamMN-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for SnellRoundhand-Bold of a particular size
    :param: size The size of the font
    */
    class func snellRoundhandBold(size: CGFloat) -> UIFont{return UIFont(name: "SnellRoundhand-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for SnellRoundhand of a particular size
    :param: size The size of the font
    */
    class func snellRoundhand(size: CGFloat) -> UIFont{return UIFont(name: "SnellRoundhand", size: size)!}
    
    
    /**
    Returns the UIFont for SnellRoundhand-Black of a particular size
    :param: size The size of the font
    */
    class func snellRoundhandBlack(size: CGFloat) -> UIFont{return UIFont(name: "SnellRoundhand-Black", size: size)!}
    
    
    /**
    Returns the UIFont for ZapfDingbatsITC of a particular size
    :param: size The size of the font
    */
    class func zapfDingbatsITC(size: CGFloat) -> UIFont{return UIFont(name: "ZapfDingbatsITC", size: size)!}
    
    
    /**
    Returns the UIFont for BodoniSvtyTwoITCTT-Bold of a particular size
    :param: size The size of the font
    */
    class func bodoniSvtyTwoITCTTBold(size: CGFloat) -> UIFont{return UIFont(name: "BodoniSvtyTwoITCTT-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for BodoniSvtyTwoITCTT-Book of a particular size
    :param: size The size of the font
    */
    class func bodoniSvtyTwoITCTTBook(size: CGFloat) -> UIFont{return UIFont(name: "BodoniSvtyTwoITCTT-Book", size: size)!}
    
    
    /**
    Returns the UIFont for BodoniSvtyTwoITCTT-BookIta of a particular size
    :param: size The size of the font
    */
    class func bodoniSvtyTwoITCTTBookIta(size: CGFloat) -> UIFont{return UIFont(name: "BodoniSvtyTwoITCTT-BookIta", size: size)!}
    
    
    /**
    Returns the UIFont for Verdana-Italic of a particular size
    :param: size The size of the font
    */
    class func verdanaItalic(size: CGFloat) -> UIFont{return UIFont(name: "Verdana-Italic", size: size)!}
    
    
    /**
    Returns the UIFont for Verdana-BoldItalic of a particular size
    :param: size The size of the font
    */
    class func verdanaBoldItalic(size: CGFloat) -> UIFont{return UIFont(name: "Verdana-BoldItalic", size: size)!}
    
    
    /**
    Returns the UIFont for Verdana of a particular size
    :param: size The size of the font
    */
    class func verdana(size: CGFloat) -> UIFont{return UIFont(name: "Verdana", size: size)!}
    
    
    /**
    Returns the UIFont for Verdana-Bold of a particular size
    :param: size The size of the font
    */
    class func verdanaBold(size: CGFloat) -> UIFont{return UIFont(name: "Verdana-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for AmericanTypewriter-CondensedLight of a particular size
    :param: size The size of the font
    */
    class func americanTypewriterCondensedLight(size: CGFloat) -> UIFont{return UIFont(name: "AmericanTypewriter-CondensedLight", size: size)!}
    
    
    /**
    Returns the UIFont for AmericanTypewriter of a particular size
    :param: size The size of the font
    */
    class func americanTypewriter(size: CGFloat) -> UIFont{return UIFont(name: "AmericanTypewriter", size: size)!}
    
    
    /**
    Returns the UIFont for AmericanTypewriter-CondensedBold of a particular size
    :param: size The size of the font
    */
    class func americanTypewriterCondensedBold(size: CGFloat) -> UIFont{return UIFont(name: "AmericanTypewriter-CondensedBold", size: size)!}
    
    
    /**
    Returns the UIFont for AmericanTypewriter-Light of a particular size
    :param: size The size of the font
    */
    class func americanTypewriterLight(size: CGFloat) -> UIFont{return UIFont(name: "AmericanTypewriter-Light", size: size)!}
    
    
    /**
    Returns the UIFont for AmericanTypewriter-Bold of a particular size
    :param: size The size of the font
    */
    class func americanTypewriterBold(size: CGFloat) -> UIFont{return UIFont(name: "AmericanTypewriter-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for AmericanTypewriter-Condensed of a particular size
    :param: size The size of the font
    */
    class func americanTypewriterCondensed(size: CGFloat) -> UIFont{return UIFont(name: "AmericanTypewriter-Condensed", size: size)!}
    
    
    /**
    Returns the UIFont for AvenirNext-UltraLight of a particular size
    :param: size The size of the font
    */
    class func avenirNextUltraLight(size: CGFloat) -> UIFont{return UIFont(name: "AvenirNext-UltraLight", size: size)!}
    
    
    /**
    Returns the UIFont for AvenirNext-UltraLightItalic of a particular size
    :param: size The size of the font
    */
    class func avenirNextUltraLightItalic(size: CGFloat) -> UIFont{return UIFont(name: "AvenirNext-UltraLightItalic", size: size)!}
    
    
    /**
    Returns the UIFont for AvenirNext-Bold of a particular size
    :param: size The size of the font
    */
    class func avenirNextBold(size: CGFloat) -> UIFont{return UIFont(name: "AvenirNext-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for AvenirNext-BoldItalic of a particular size
    :param: size The size of the font
    */
    class func avenirNextBoldItalic(size: CGFloat) -> UIFont{return UIFont(name: "AvenirNext-BoldItalic", size: size)!}
    
    
    /**
    Returns the UIFont for AvenirNext-DemiBold of a particular size
    :param: size The size of the font
    */
    class func avenirNextDemiBold(size: CGFloat) -> UIFont{return UIFont(name: "AvenirNext-DemiBold", size: size)!}
    
    
    /**
    Returns the UIFont for AvenirNext-DemiBoldItalic of a particular size
    :param: size The size of the font
    */
    class func avenirNextDemiBoldItalic(size: CGFloat) -> UIFont{return UIFont(name: "AvenirNext-DemiBoldItalic", size: size)!}
    
    
    /**
    Returns the UIFont for AvenirNext-Medium of a particular size
    :param: size The size of the font
    */
    class func avenirNextMedium(size: CGFloat) -> UIFont{return UIFont(name: "AvenirNext-Medium", size: size)!}
    
    
    /**
    Returns the UIFont for AvenirNext-HeavyItalic of a particular size
    :param: size The size of the font
    */
    class func avenirNextHeavyItalic(size: CGFloat) -> UIFont{return UIFont(name: "AvenirNext-HeavyItalic", size: size)!}
    
    
    /**
    Returns the UIFont for AvenirNext-Heavy of a particular size
    :param: size The size of the font
    */
    class func avenirNextHeavy(size: CGFloat) -> UIFont{return UIFont(name: "AvenirNext-Heavy", size: size)!}
    
    
    /**
    Returns the UIFont for AvenirNext-Italic of a particular size
    :param: size The size of the font
    */
    class func avenirNextItalic(size: CGFloat) -> UIFont{return UIFont(name: "AvenirNext-Italic", size: size)!}
    
    
    /**
    Returns the UIFont for AvenirNext-Regular of a particular size
    :param: size The size of the font
    */
    class func avenirNextRegular(size: CGFloat) -> UIFont{return UIFont(name: "AvenirNext-Regular", size: size)!}
    
    
    /**
    Returns the UIFont for AvenirNext-MediumItalic of a particular size
    :param: size The size of the font
    */
    class func avenirNextMediumItalic(size: CGFloat) -> UIFont{return UIFont(name: "AvenirNext-MediumItalic", size: size)!}
    
    
    /**
    Returns the UIFont for Baskerville-Italic of a particular size
    :param: size The size of the font
    */
    class func baskervilleItalic(size: CGFloat) -> UIFont{return UIFont(name: "Baskerville-Italic", size: size)!}
    
    
    /**
    Returns the UIFont for Baskerville-SemiBold of a particular size
    :param: size The size of the font
    */
    class func baskervilleSemiBold(size: CGFloat) -> UIFont{return UIFont(name: "Baskerville-SemiBold", size: size)!}
    
    
    /**
    Returns the UIFont for Baskerville-BoldItalic of a particular size
    :param: size The size of the font
    */
    class func baskervilleBoldItalic(size: CGFloat) -> UIFont{return UIFont(name: "Baskerville-BoldItalic", size: size)!}
    
    
    /**
    Returns the UIFont for Baskerville-SemiBoldItalic of a particular size
    :param: size The size of the font
    */
    class func baskervilleSemiBoldItalic(size: CGFloat) -> UIFont{return UIFont(name: "Baskerville-SemiBoldItalic", size: size)!}
    
    
    /**
    Returns the UIFont for Baskerville-Bold of a particular size
    :param: size The size of the font
    */
    class func baskervilleBold(size: CGFloat) -> UIFont{return UIFont(name: "Baskerville-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for Baskerville of a particular size
    :param: size The size of the font
    */
    class func baskerville(size: CGFloat) -> UIFont{return UIFont(name: "Baskerville", size: size)!}
    
    
    /**
    Returns the UIFont for KhmerSangamMN of a particular size
    :param: size The size of the font
    */
    class func khmerSangamMN(size: CGFloat) -> UIFont{return UIFont(name: "KhmerSangamMN", size: size)!}
    
    
    /**
    Returns the UIFont for Didot-Italic of a particular size
    :param: size The size of the font
    */
    class func didotItalic(size: CGFloat) -> UIFont{return UIFont(name: "Didot-Italic", size: size)!}
    
    
    /**
    Returns the UIFont for Didot-Bold of a particular size
    :param: size The size of the font
    */
    class func didotBold(size: CGFloat) -> UIFont{return UIFont(name: "Didot-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for Didot of a particular size
    :param: size The size of the font
    */
    class func didot(size: CGFloat) -> UIFont{return UIFont(name: "Didot", size: size)!}
    
    
    /**
    Returns the UIFont for SavoyeLetPlain of a particular size
    :param: size The size of the font
    */
    class func savoyeLetPlain(size: CGFloat) -> UIFont{return UIFont(name: "SavoyeLetPlain", size: size)!}
    
    
    /**
    Returns the UIFont for BodoniOrnamentsITCTT of a particular size
    :param: size The size of the font
    */
    class func bodoniOrnamentsITCTT(size: CGFloat) -> UIFont{return UIFont(name: "BodoniOrnamentsITCTT", size: size)!}
    
    
    /**
    Returns the UIFont for Symbol of a particular size
    :param: size The size of the font
    */
    class func symbol(size: CGFloat) -> UIFont{return UIFont(name: "Symbol", size: size)!}
    
    
    /**
    Returns the UIFont for Menlo-Italic of a particular size
    :param: size The size of the font
    */
    class func menloItalic(size: CGFloat) -> UIFont{return UIFont(name: "Menlo-Italic", size: size)!}
    
    
    /**
    Returns the UIFont for Menlo-Bold of a particular size
    :param: size The size of the font
    */
    class func menloBold(size: CGFloat) -> UIFont{return UIFont(name: "Menlo-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for Menlo-Regular of a particular size
    :param: size The size of the font
    */
    class func menloRegular(size: CGFloat) -> UIFont{return UIFont(name: "Menlo-Regular", size: size)!}
    
    
    /**
    Returns the UIFont for Menlo-BoldItalic of a particular size
    :param: size The size of the font
    */
    class func menloBoldItalic(size: CGFloat) -> UIFont{return UIFont(name: "Menlo-BoldItalic", size: size)!}
    
    
    /**
    Returns the UIFont for BodoniSvtyTwoSCITCTT-Book of a particular size
    :param: size The size of the font
    */
    class func bodoniSvtyTwoSCITCTTBook(size: CGFloat) -> UIFont{return UIFont(name: "BodoniSvtyTwoSCITCTT-Book", size: size)!}
    
    
    /**
    Returns the UIFont for DINAlternate-Bold of a particular size
    :param: size The size of the font
    */
    class func dinAlternateBold(size: CGFloat) -> UIFont{return UIFont(name: "DINAlternate-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for Papyrus of a particular size
    :param: size The size of the font
    */
    class func papyrus(size: CGFloat) -> UIFont{return UIFont(name: "Papyrus", size: size)!}
    
    
    /**
    Returns the UIFont for Papyrus-Condensed of a particular size
    :param: size The size of the font
    */
    class func papyrusCondensed(size: CGFloat) -> UIFont{return UIFont(name: "Papyrus-Condensed", size: size)!}
    
    
    /**
    Returns the UIFont for EuphemiaUCAS-Italic of a particular size
    :param: size The size of the font
    */
    class func euphemiaUCASItalic(size: CGFloat) -> UIFont{return UIFont(name: "EuphemiaUCAS-Italic", size: size)!}
    
    
    /**
    Returns the UIFont for EuphemiaUCAS of a particular size
    :param: size The size of the font
    */
    class func euphemiaUCAS(size: CGFloat) -> UIFont{return UIFont(name: "EuphemiaUCAS", size: size)!}
    
    
    /**
    Returns the UIFont for EuphemiaUCAS-Bold of a particular size
    :param: size The size of the font
    */
    class func euphemiaUCASBold(size: CGFloat) -> UIFont{return UIFont(name: "EuphemiaUCAS-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for TeluguSangamMN of a particular size
    :param: size The size of the font
    */
    class func teluguSangamMN(size: CGFloat) -> UIFont{return UIFont(name: "TeluguSangamMN", size: size)!}
    
    
    /**
    Returns the UIFont for TeluguSangamMN-Bold of a particular size
    :param: size The size of the font
    */
    class func teluguSangamMNBold(size: CGFloat) -> UIFont{return UIFont(name: "TeluguSangamMN-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for BanglaSangamMN-Bold of a particular size
    :param: size The size of the font
    */
    class func banglaSangamMNBold(size: CGFloat) -> UIFont{return UIFont(name: "BanglaSangamMN-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for BanglaSangamMN of a particular size
    :param: size The size of the font
    */
    class func banglaSangamMN(size: CGFloat) -> UIFont{return UIFont(name: "BanglaSangamMN", size: size)!}
    
    
    /**
    Returns the UIFont for Zapfino of a particular size
    :param: size The size of the font
    */
    class func zapfino(size: CGFloat) -> UIFont{return UIFont(name: "Zapfino", size: size)!}
    
    
    /**
    Returns the UIFont for BodoniSvtyTwoOSITCTT-Book of a particular size
    :param: size The size of the font
    */
    class func bodoniSvtyTwoOSITCTTBook(size: CGFloat) -> UIFont{return UIFont(name: "BodoniSvtyTwoOSITCTT-Book", size: size)!}
    
    
    /**
    Returns the UIFont for BodoniSvtyTwoOSITCTT-Bold of a particular size
    :param: size The size of the font
    */
    class func bodoniSvtyTwoOSITCTTBold(size: CGFloat) -> UIFont{return UIFont(name: "BodoniSvtyTwoOSITCTT-Bold", size: size)!}
    
    
    /**
    Returns the UIFont for BodoniSvtyTwoOSITCTT-BookIt of a particular size
    :param: size The size of the font
    */
    class func bodoniSvtyTwoOSITCTTBookIt(size: CGFloat) -> UIFont{return UIFont(name: "BodoniSvtyTwoOSITCTT-BookIt", size: size)!}
    
    
    /**
    Returns the UIFont for DINCondensed-Bold of a particular size
    :param: size The size of the font
    */
    class func dinCondensedBold(size: CGFloat) -> UIFont{return UIFont(name: "DINCondensed-Bold", size: size)!}
    
}
