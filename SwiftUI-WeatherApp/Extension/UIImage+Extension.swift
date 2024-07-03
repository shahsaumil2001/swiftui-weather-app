//
//  UIImage+Extension.swift
//  SwiftUI-WeatherApp
//
//   
//

import Foundation
import UIKit
import ImageIO

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
private func < <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (left?, right?):
    return left < right
  case (nil, _?):
    return true
  default:
    return false
  }
}

extension UIImage {

    ///
    /// The func is `gifImageWithData` returns Image from Data
    ///  extension UIImage's `gifImageWithData` method
    ///
    public class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("image doesn't exist")
            return nil
        }
        return UIImage.animatedImageWithSource(source)
    }

    ///
    /// The func is `gifImageWithURL` returns Image from URL
    ///  extension UIImage's `gifImageWithURL` method
    ///
    public class func gifImageWithURL(_ gifUrl: String) -> UIImage? {
        guard let bundleURL: URL = URL(string: gifUrl)
        else {
            print("image named \"\(gifUrl)\" doesn't exist")
            return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("image named \"\(gifUrl)\" into NSData")
            return nil
        }
        return gifImageWithData(imageData)
    }

    ///
    /// The func is `gifImageWithName` returns Image from String
    ///  extension UIImage's `gifImageWithName` method
    ///
    public class func gifImageWithName(_ name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
            print("SwiftGif: This image named \"\(name)\" does not exist")
            return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        return gifImageWithData(imageData)
    }

    ///
    /// The func is `delayForImageAtIndex` returns delay for Image
    ///  extension UIImage's `delayForImageAtIndex` method
    ///
    class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1

        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(
            CFDictionaryGetValue(cfProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()),
            to: CFDictionary.self)

        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                                                             Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }

        delay = delayObject as? Double ?? 00.00
        if delay < 0.1 {
            delay = 0.1
        }
        return delay
    }

    ///
    /// The func is `gcdForPair` returns gcd for points
    ///  extension UIImage's `gcdForPair` method
    ///
    class func gcdForPair(_ aPoint: Int?, _ bPoint: Int?) -> Int {
        var aPoint = aPoint
        var bPoint = bPoint
        if bPoint == nil || aPoint == nil {
            if bPoint != nil {
                return bPoint!
            } else if aPoint != nil {
                return aPoint!
            } else {
                return 0
            }
        }

        if aPoint < bPoint {
            let cPoint = aPoint
            aPoint = bPoint
            bPoint = cPoint
        }

        var rest: Int
        while true {
            rest = aPoint! % bPoint!
            if rest == 0 {
                return bPoint!
            } else {
                aPoint = bPoint
                bPoint = rest
            }
        }
    }

    ///
    /// The func is `gcdForArray` returns gcd for array
    ///  extension UIImage's `gcdForArray` method
    ///
    class func gcdForArray(_ array: [Int]) -> Int {
        if array.isEmpty {
            return 1
        }
        var gcd = array[0]
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        return gcd
    }

    ///
    /// The func is `animatedImageWithSource` returns animated image
    ///  extension UIImage's `animatedImageWithSource` method
    ///
    class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()

        for index in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, index, nil) {
                images.append(image)
            }
            let delaySeconds = UIImage.delayForImageAtIndex(Int(index),
                                                            source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }

        let duration: Int = {
            var sum = 0
            for val: Int in delays {
                sum += val
            }
            return sum
        }()

        let gcd = gcdForArray(delays)
        var frames = [UIImage]()
        var frame: UIImage
        var frameCount: Int
        for index in 0..<count {
            frame = UIImage(cgImage: images[Int(index)])
            frameCount = Int(delays[Int(index)] / gcd)
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }

        let animation = UIImage.animatedImage(with: frames,
                                              duration: Double(duration) / 1000.0)
        return animation
    }
}
