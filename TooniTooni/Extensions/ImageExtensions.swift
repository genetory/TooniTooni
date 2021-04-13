//
//  UIImage+Color.swift
//  StoryPlay
//
//  Created by GENETORY on 2020/05/12.
//  Copyright © 2020 GENETORY. All rights reserved.
//

import UIKit

extension UIImage {

    // 1픽셀 이미지 만들기
    class func imageFromColor(_ color: UIColor, width: CGFloat = 1.0, height: CGFloat = 1.0) -> UIImage? {
        var image: UIImage?

        let rect = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: width, height: height))
        
        UIGraphicsBeginImageContext(rect.size)
        if let context: CGContext = UIGraphicsGetCurrentContext() {

            context.setFillColor(color.cgColor)
            context.fill(rect)

            image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }

        return image
    }
    
    // 퍼센티지로 이미지 줄이기
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    // 너비로 이미지 줄이기
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    // 사이즈로 이미지 줄이기
    func resize(_ image: UIImage, size: Float) -> UIImage {
        var actualHeight = Float(image.size.height)
        var actualWidth = Float(image.size.width)
        let maxHeight: Float = size
        let maxWidth: Float = size
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        let compressionQuality: Float = 0.7
        //50 percent compression
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = img?.jpegData(compressionQuality: CGFloat(compressionQuality))
        UIGraphicsEndImageContext()
        return UIImage(data: imageData!) ?? UIImage()
    }

    // 용량으로 이미지 줄이기
    func resizedTo3MB() -> UIImage? {
        guard let imageData = self.pngData() else { return nil }

        var resizingImage = self
        var imageSizeKB = Double(imageData.count) / 1000.0 // ! Or devide for 1024 if you need KB but not kB

        while imageSizeKB > 3000 { // ! Or use 1024 if you need KB but not kB
            guard let resizedImage = resizingImage.resized(withPercentage: 0.9),
                let imageData = resizedImage.pngData()
                else { return nil }

            resizingImage = resizedImage
            imageSizeKB = Double(imageData.count) / 1000.0 // ! Or devide for 1024 if you need KB but not kB
        }

        return resizingImage
    }

}
