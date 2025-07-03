//
//  UIProperty.swift
//  IOSNamingConvention
//
//  Created by theonetech on 29/07/20.
//  Copyright © 2020 theonetech. All rights reserved.
//

import UIKit

@IBDesignable extension UIView {
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = self.layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.clipsToBounds = newValue > 0
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let color = self.layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var maskToBounds: Bool {
        get {
            return self.layer.masksToBounds
        }
        set {
            self.layer.masksToBounds = newValue
        }
    }
}

@IBDesignable extension UIButton {
    @IBInspectable var adjustsFontSizeToFitWidth: Bool {
        get {
            return self.titleLabel?.adjustsFontSizeToFitWidth ?? false
        }
        set {
            self.titleLabel?.adjustsFontSizeToFitWidth = newValue
        }
    }
    
    @IBInspectable var numberOfLines: Int {
        get {
            return self.titleLabel?.numberOfLines ?? 1
        }
        set {
            self.titleLabel?.numberOfLines = newValue
        }
    }
    
    @IBInspectable var imageViewContentMode: Int {
        get {
            return self.imageView?.contentMode.rawValue ?? 0
        }
        set {
            self.imageView?.contentMode = UIView.ContentMode(rawValue: newValue) ?? .scaleToFill
        }
    }
    
    @IBInspectable var textAlignment: Int {
        get {
            return self.titleLabel?.textAlignment.rawValue ?? 0
        }
        set {
            self.titleLabel?.textAlignment = NSTextAlignment(rawValue: newValue) ?? .left
        }
    }
    
    @IBInspectable var sizeImage: CGSize {
        get {
            return self.imageView?.image?.size ?? CGSize.zero
        }
        set {
            if let image = self.imageView?.image {
                let imgUpdate = image.resizedImage(Size: newValue)
                self.setImage(imgUpdate, for: .normal)
            }
        }
    }
}

@IBDesignable extension UILabel {
    @IBInspectable var adjustsFontSizeToFitWidthText: Bool {
        get {
            return self.adjustsFontSizeToFitWidth
        }
        set {
            self.adjustsFontSizeToFitWidth = newValue
        }
    }
}

@IBDesignable extension UITextField {
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    @IBInspectable var leftViewWidth: CGFloat {
        get {
            return leftView?.frame.width ?? 0
        }
        set {
            let viewGap = UIView.init(frame: CGRect(x: 0, y: 0, width: newValue, height: self.frame.height))
            self.leftView = viewGap
            self.leftViewMode = .always
        }
    }
    
    @IBInspectable var rightViewWidth: CGFloat {
        get {
            return rightView?.frame.width ?? 0
        }
        set {
            let viewGap = UIView.init(frame: CGRect(x: 0, y: 0, width: newValue, height: self.frame.height))
            self.rightView = viewGap
            self.rightViewMode = .always
        }
    }
}

@IBDesignable extension UIImageView {
    @IBInspectable var templateImage: Bool {
        get {
            return (self.image?.renderingMode == .alwaysTemplate)
        }
        set {
            self.image = self.image?.withRenderingMode(newValue ? .alwaysTemplate : .automatic)
        }
    }
}

extension UILabel {
    
    func setIcon(Name name: String, size :CGSize ) {
        
        let imageAttachment =  NSTextAttachment()
        imageAttachment.image = UIImage(named:name)?.resizedImage(Size: size)?.withRenderingMode(.alwaysOriginal)
        //Set bound to reposition
        let imageOffsetY:CGFloat = -2.0
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        //Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        //Initialize mutable string
        let completeText = NSMutableAttributedString(string: "")
        //Add image to mutable string
        completeText.append(attachmentString)
        //Add your text to mutable string
        let  textAfterIcon = NSMutableAttributedString(string: "  \(self.text ?? "")" )
        completeText.append(textAfterIcon)
        self.textAlignment = .center
        self.attributedText = completeText
    }
  
}

extension UIImage {
    func resizedImage(Size sizeImage: CGSize) -> UIImage? {
        let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: sizeImage.width, height: sizeImage.height))
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        self.draw(in: frame)
        let resizedImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.withRenderingMode(.alwaysOriginal)
        return resizedImage
    }
    
    convenience init(withBackground color: UIColor) {
        
        let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.init(ciImage: CIImage(image: image)!)
        
    }
    
    func convertImageToBase64String (compress: CGFloat) -> String {
        return self.jpegData(compressionQuality: compress)!.base64EncodedString()
    }
    func jpeg(_ jpegQuality: CGFloat) -> Data? {
        return jpegData(compressionQuality: jpegQuality)
    }
}
extension UITabBar {
    func activeTintColor() {
        if let items = items {
            for item in items {
                item.selectedImage = item.selectedImage?.resizedImage(Size: CGSize(width: 27.5, height: 27.5))?.withRenderingMode(.alwaysOriginal)
                item.image = item.image?.resizedImage(Size: CGSize(width: 27.5, height: 27.5))?.withRenderingMode(.alwaysOriginal)
            }
        }
    }
}
