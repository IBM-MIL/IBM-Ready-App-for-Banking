/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import Foundation
import AVFoundation
import UIKit

//Custom images for the project
extension UIImage{
    class func backArrowWhite()->UIImage{
        return UIImage(named: "back_white")!
    }
    
    class func backArrowGray()->UIImage{
        return UIImage(named: "back_grey")!
    }
    
    class func menuWhite()->UIImage{
        return UIImage(named: "menu_white")!
    }
    
    class func menuGray()->UIImage{
        return UIImage(named: "menu_grey")!
    }
    
    class func activePageDot()->UIImage{
        return UIImage(named: "page_dot_fill")!
    }
    
    class func inactivePageDot()->UIImage{
        return UIImage(named: "page_dot")!
    }
    
    class func activeGreenPageDot()->UIImage{
        return UIImage(named: "page_dot_fill_green")!
    }
    
    class func inactiveGreenPageDot()->UIImage{
        return UIImage(named: "page_dot_green")!
    }
}

extension UIImage{
    func croppedImage(bound : CGRect) -> UIImage
    {
        var scaledBounds : CGRect = CGRectMake(bound.origin.x * self.scale, bound.origin.y * self.scale, bound.size.width * self.scale, bound.size.height * self.scale)
        var imageRef = CGImageCreateWithImageInRect(self.CGImage, scaledBounds)
        var croppedImage : UIImage = UIImage(CGImage: imageRef, scale: self.scale, orientation: UIImageOrientation.Up)!
        return croppedImage;
    }
    
    /**
    Creates an image from a video. Created with help from http://stackoverflow.com/questions/8906004/thumbnail-image-of-video/8906104#8906104
    
    :param: videoURL The url of the video to grab an image from
    
    :returns: The thumbnail image
    */
    class func getThumbnailFromVideo(videoURL: NSURL) -> UIImage {
        var asset: AVURLAsset = AVURLAsset(URL: videoURL, options: nil)
        var imageGen: AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
        imageGen.appliesPreferredTrackTransform = true
        var time = CMTimeMakeWithSeconds(1.0, 600)
        var image: CGImageRef = imageGen.copyCGImageAtTime(time, actualTime: nil, error: nil)
        var thumbnail: UIImage = UIImage(CGImage: image)!
        
        return thumbnail
    }
    
    /**
    Create an image of a given color
    
    :param: color  The color that the image will have
    :param: width  Width of the returned image
    :param: height Height of the returned image
    
    :returns: An image with the color, height and width
    */
    class func imageWithColor(color: UIColor, width: CGFloat, height: CGFloat) -> UIImage {
        var rect = CGRect(x: 0, y: 0, width: width, height: height)
        UIGraphicsBeginImageContext(rect.size)
        var context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /**
    Method to perform crop based on square inside app frame
    
    :param: view the view image was capture in
    :param: square the crop square over the image
    :param: fromCam determine how to handle the passed in image
    
    :returns: UIImage - the cropped image
    */
    func cropImageInView(view: UIView, square: CGRect, fromCam: Bool) -> UIImage {
        var cropSquare: CGRect
        var frameHeight = view.frame.size.height
        var frameWidth = view.frame.size.width
        var imageHeight = self.size.height
        var imageWidth = self.size.width
        
        // "if" creates a square from cameraroll image, else creates square from square frame in camera
        if !fromCam {
            
            var edge: CGFloat
            if imageWidth > imageHeight {
                edge = imageHeight
            } else {
                edge = imageWidth
            }
            
            var posX = (imageWidth  - edge) / 2.0
            var posY = (imageHeight - edge) / 2.0
            
            cropSquare = CGRectMake(posX, posY, edge, edge)
            
        } else {
            
            var imageScale: CGFloat!
            imageScale = imageWidth / frameWidth
            // x and y are switched because image has -90 degrees rotation by default
            cropSquare = CGRectMake(square.origin.y * imageScale, square.origin.x * imageScale, square.size.width * imageScale, square.size.height * imageScale)
        }
        
        var imageRef = CGImageCreateWithImageInRect(self.CGImage, cropSquare)
        return UIImage(CGImage: imageRef, scale: UIScreen.mainScreen().scale, orientation: self.imageOrientation)!
    }
}