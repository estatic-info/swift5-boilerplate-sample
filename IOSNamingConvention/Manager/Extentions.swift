//
//  Extentions.swift
//  IOSNamingConvention
//
//  Created by theonetech on 30/07/20.
//  Copyright © 2020 theonetech. All rights reserved.
//

import Foundation
import UIKit

let regexNumericLimit        = "^.{3,10}$"
let regexAlphaNumeric        = "[A-Za-z0-9]{3,10}"
let regexEmail               = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
let regexRequireAlphaNumeric = "[A-Za-z0-9]{6,20}"
let regexPhone               = "[0-9]{3}\\-[0-9]{3}\\-[0-9]{4}"

extension Storyboard {
    static var Main = UIStoryboard(name: Storyboard.main, bundle: nil)
}

class Extentions: NSObject {
    // MARK: - Declare Objects
    static let shared = Extentions()
    
    override init() {
        super.init()
    }
}
extension String {
    // MARK: -
    
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
    
    var trim : String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    var url : URL? {
        var urlWeb = URL(string: self.trim)
        if urlWeb == nil {
            urlWeb = URL(string: self.trim.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")
        }
        return urlWeb
    }
    
    var isValidEmail : Bool {
        let predicate = NSPredicate(format:"SELF MATCHES %@", regexEmail)
        let isValid = predicate.evaluate(with: self)
        return isValid
    }
    
    var isValidPhone : Bool {
        let predicate = NSPredicate(format:"SELF MATCHES %@", regexPhone)
        let isValid = predicate.evaluate(with: self)
        return isValid
    }
    
    var containSpecialCharacter : Bool {
        let regex = try? NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: NSRegularExpression.Options())
        let match = regex?.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(), range: NSRange(location: 0, length: self.count))
        let exist = (match != nil)
        return exist
    }
    
    var isFloatValue : Bool {
        let allowedCharacters = "0123456789."
        let isValid = allowedCharacters.contains(self)
        return isValid
    }
    
    var isDecimalValue : Bool {
        let isValid = (self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) != nil)
        return !isValid
    }
    
    // MARK: -
    
    func lengthMax(Length length:Int) -> Bool {
        return (self.count >= length)
    }
    
    func lengthMin(Length length:Int) -> Bool {
        return (self.count >= length)
    }
    
    func lengthEqual(Length length:Int) -> Bool {
        let isValid = (self.count == length)
        return isValid
    }
    
    // MARK: -

    var removeWhiteSpaceAndNewLine : String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var removeSpecialCharacter : String {
        let charSet = Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890")
        let strFilter = String(self.filter {charSet.contains($0)})
        return strFilter
    }
    
    var removeAlphabets : String {
        let charSet = Set("0123456789")
        let strFilter = String(self.filter {charSet.contains($0)})
        return strFilter
    }
    
    // MARK: -
    
    var encode : String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    var decode : String {
        return self.removingPercentEncoding ?? ""
    }
    var encodeCharacter : String {
        var encodedParameter = addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        encodedParameter = encodedParameter.replacingOccurrences(of: "+", with: "%2B")
        return encodedParameter
    }

    func stringToAttributeString(Font font:[UIFont],Colors colors:[UIColor]) -> NSMutableAttributedString? {
        let arrStr = self.split(separator: ":")
        let str = NSMutableAttributedString()
        for (key,value) in arrStr.enumerated() {
            var attributes = [NSAttributedString.Key : Any]()
            if key < font.count {
                attributes = [
                    NSAttributedString.Key.font : font[key],
                    NSAttributedString.Key.foregroundColor : colors[key]
                ]
            } else {
                attributes = [
                    NSAttributedString.Key.font : font.last as Any,
                    NSAttributedString.Key.foregroundColor : colors.last as Any
                ]
            }
            var subStr = String(value)
            if key < arrStr.count-1 {
                subStr += "\(subStr):"
            }
            let title = NSAttributedString(string: subStr, attributes: attributes)
            str.append(title)
        }
        return str
    }
    func attributeString(Attributes dictAttribute: [NSAttributedString.Key : Any]? = nil) -> NSMutableAttributedString? {
        var attrStr = NSMutableAttributedString.init(string: self, attributes: dictAttribute)
        if let htmlData = self.data(using: .utf8, allowLossyConversion: true) {
            let dictOption = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
            do {
                // try attrStr.read(from: htmlData, options: dictOption, documentAttributes: nil)
                attrStr = try NSMutableAttributedString.init(data: htmlData, options: dictOption, documentAttributes: nil)
                if let attributes = dictAttribute {
                    let range = NSRange(location: 0, length: (attrStr.string.count))
                    attrStr.addAttributes(attributes, range: range)
                    attrStr.addAttributes(attributes, range: ((attrStr.string as NSString?)?.range(of: attrStr.string))!)
                }
                return attrStr
            } catch {
                print("attributeString Error:",error)
            }
        }
        return attrStr
    }

    func height(withMaxWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    func width(withMaxHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    var base64Encode : String? {
        let dataStr = self.data(using: .utf8)
        let strText = dataStr?.base64EncodedString()
        return strText
    }
    var base64Decode : String? {
        if let dataStr = Data(base64Encoded: self) {
            let strText = String(data: dataStr, encoding: .utf8)
            return strText
        }
        return nil
    }
    func utf8DecodedString() -> String {
        let data = self.data(using: .utf8)
        if let message = String(data: data!, encoding: .nonLossyASCII) {
            return message
        }
        return self
    }
    func utf8EncodedString() -> String {
        let messageData = self.data(using: .nonLossyASCII)
        let text = String(data: messageData!, encoding: .utf8)
        return text ?? ""
    }
    func size(font: UIFont, maxSize: CGSize) -> CGSize {
        let attrString = NSAttributedString.init(string: self, attributes: [NSAttributedString.Key.font:font])
        let rect = attrString.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        let size = CGSize(width: rect.size.width, height: rect.size.height)
        return size
    }
    var capitalizeFirst: String {
        if !self.isEmpty {
            return self.replacingCharacters(in: self.startIndex...self.startIndex, with: String(self[self.startIndex]).capitalized)
        }
        return self
    }
    var isExistPath : Bool {
        let exist = FileManager.default.fileExists(atPath: self)
        return exist
    }
    func html(_ font:UIFont? = nil, _ colorHex: String = "#000000") -> String {
        let strHTML = "<span style=\"font-family: \(font?.fontName ?? ""); font-size: \(font?.pointSize ?? 1.0); color: \(colorHex)\">\(self)</span>"
        return strHTML
    }
}
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
extension UIColor {
    convenience init(Red red: Int,Green green: Int,Blue blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(Hexcode rgb: Int) {
        self.init(
            Red: (rgb >> 16) & 0xFF,
            Green: (rgb >> 8) & 0xFF,
            Blue: rgb & 0xFF
        )
    }
    var hexCode : String {
        var red:CGFloat = 0
        var green:CGFloat = 0
        var blue:CGFloat = 0
        var alpha:CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let rgb:Int = (Int)(red*255)<<16 | (Int)(green*255)<<8 | (Int)(blue*255)<<0
        return String(format:"#%06x", rgb)
    }
}
extension Dictionary {
    var encodeQuery : String {
        if let dictList : [String:Any] = self as? [String:Any] {
        let queryEncode = dictList.map({ (param) -> String in
            var value = param.value
            if let isBool = value as? Bool {
                value = isBool.hashValue
            }
            let strParam = param.key + "=" + "\(value)"
            return strParam
        }).joined(separator: "&")
            
        return queryEncode
        } else {
            return ""
        }
    }
}
extension NSObject {
    var rootController : UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }
}
extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}
extension UITextField {
    func addBottomBorder(color : UIColor = UIColor.black) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = color.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
