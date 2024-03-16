//
//  ImageUtils.swift
//  DS_ExpertIOS
//
//  Created by Admin on 22/02/24.
//

import UIKit
import SwiftUI

protocol ImageUtils {
  func getImageData(from: String) -> Data?
}

class ImageUtilsImplementation: ImageUtils {
  func getImageData(from: String) -> Data? {
    return UIImage(named: from)?.pngData()
  }
}

extension UIImage {
  func resize(Size sizeImage: CGSize) -> UIImage? {
    let frame = CGRect(
      origin: CGPoint.zero,
      size: CGSize(width: sizeImage.width, height: sizeImage.height)
    )
    UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
    self.draw(in: frame)
    let resizedImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    self.withRenderingMode(.alwaysOriginal)
    return resizedImage
  }
}

extension Image {
  
  public func asUIImage() -> UIImage {
    let controller = UIHostingController(rootView: self)
    controller.view.backgroundColor = .clear
    
    controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
    let window = UIApplication.shared.connectedScenes
      .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
      .first { $0.isKeyWindow }
    
    window?.rootViewController?.view.addSubview(controller.view)
    
    let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
    controller.view.bounds = CGRect(origin: .zero, size: size)
    controller.view.sizeToFit()
    
    let renderer = UIGraphicsImageRenderer(bounds: controller.view.bounds)
    let image = renderer.image { rendererContext in
      controller.view.layer.render(in: rendererContext.cgContext)
    }
    controller.view.removeFromSuperview()
    return image
  }
  
}
