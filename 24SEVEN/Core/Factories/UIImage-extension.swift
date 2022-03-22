import Foundation
import UIKit
import SDWebImageSVGCoder



public extension UIImage
{
    func tintColor(with color: UIColor) -> UIImage
    {
        guard let cgImage = cgImage else {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return self
        }
        color.setFill()
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(.normal)
        
        let rect = CGRect(origin: .zero, size: size)
        context.clip(to: rect, mask: cgImage)
        context.fill(rect)
        
        let result = UIGraphicsGetImageFromCurrentImageContext() ?? self
        UIGraphicsEndImageContext()
        return result
    }
    
    
    
    func imageWithImage(image: UIImage,
                        targetSize: CGSize) -> UIImage?
    {
        if let imageData = image.pngData()
        {
            let bytes = imageData.count
            let kb = Double(bytes) / 1024.0
            let imageMB = kb / 1024.0
            
            if imageMB < 2.0
            {
                return image
            }
        }
        
        
        //If scaleFactor is not touched, no scaling will occur
        var scaleFactor =  CGFloat(1.0)
        
        //Deciding which factor to use to scale the image (factor = targetSize / imageSize)
        if (image.size.width > targetSize.width || image.size.height > targetSize.height)
        {
            scaleFactor = targetSize.width / image.size.width
            
            if (!(scaleFactor > targetSize.height / image.size.height))
            {
                scaleFactor = targetSize.height / image.size.height; // scale to fit heigth.
            }
        }
            
        UIGraphicsBeginImageContext(targetSize)

        //Creating the rect where the scaled image is drawn in
        let rect = CGRect(x: (targetSize.width - image.size.width * scaleFactor) / 2,
                          y: (targetSize.height -  image.size.height * scaleFactor) / 2,
                          width: image.size.width * scaleFactor,
                          height: image.size.height * scaleFactor)
            

        //Draw the image into the rect
        image.draw(in: rect)

        //Saving the image, ending image context
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        
        if let newImage = scaledImage,
            let imageData = newImage.pngData()
        {
            let bytes = imageData.count
            let kb = Double(bytes) / 1024.0
            let imageMB = kb / 1024.0
            
            if imageMB > 2.0
            {
                return imageWithImage(image: newImage,
                                      targetSize: CGSize(width: newImage.size.width/2.0,
                                                         height: newImage.size.height/2.0))
            }
        }
        
        return scaledImage
    }
    
    
    
    
    static func imageSvgFormat(name: String) -> UIImage
    {
        let svgImage: SVGKImage = SVGKImage(named: name)
        let convertedImage: UIImage = svgImage.uiImage
                
        
        return convertedImage
    }
    
    
    
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage
    {
       let size = image.size

       let widthRatio  = targetSize.width  / size.width
       let heightRatio = targetSize.height / size.height

       // Figure out what our orientation is, and use that to form the rectangle
       var newSize: CGSize
       if(widthRatio > heightRatio) {
           newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
       } else {
           newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
       }

       // This is the rect that we've calculated out and this is what is actually used below
       let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

       // Actually do the resizing to the rect using the ImageContext stuff
       UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
       image.draw(in: rect)
       let newImage = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()

       return newImage!
   }


    
    func withBackground(color: UIColor, opaque: Bool = true) -> UIImage
    {
      UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
          
      guard let ctx = UIGraphicsGetCurrentContext(), let image = cgImage else { return self }
      defer { UIGraphicsEndImageContext() }
          
      let rect = CGRect(origin: .zero, size: size)
      ctx.setFillColor(color.cgColor)
      ctx.fill(rect)
      ctx.concatenate(CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: size.height))
      ctx.draw(image, in: rect)
          
      return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
    
    
    func withRoundedCorners(radius: CGFloat? = nil) -> UIImage?
    {
        let maxRadius = min(size.width, size.height) / 2
        let cornerRadius: CGFloat
        if let radius = radius, radius > 0 && radius <= maxRadius
        {
            cornerRadius = radius
        }
        else
        {
            cornerRadius = maxRadius
        }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    
    func cropped(boundingBox: CGRect) -> UIImage?
    {
        guard let cgImage = self.cgImage?.cropping(to: boundingBox)
            else
        {
            return nil
        }

        return UIImage(cgImage: cgImage)
    }
}
