//
//  UIButton+Ext.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/11.
//

import UIKit

extension UIButton {
    //    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
    //        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
    //        guard let context = UIGraphicsGetCurrentContext() else { return }
    //        context.setFillColor(color.cgColor)
    //        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
    //
    //        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
    //        UIGraphicsEndImageContext()
    //
    //        self.setBackgroundImage(backgroundImage, for: state)
    //    }
    func alignVertical(spacing: CGFloat = 6.0) {
        guard let imageSize = imageView?.image?.size,
              let text = titleLabel?.text,
              let font = titleLabel?.font
        else { return }
        
        titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: -imageSize.width,
            bottom: -(imageSize.height + spacing),
            right: 0.0
        )
        
        let titleSize = text.size(withAttributes: [.font: font])
        imageEdgeInsets = UIEdgeInsets(
            top: -(titleSize.height + spacing),
            left: 0.0,
            bottom: 0.0,
            right: -titleSize.width
        )
        
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0
        contentEdgeInsets = UIEdgeInsets(
            top: edgeOffset,
            left: 0.0,
            bottom: edgeOffset,
            right: 0.0
        )
    }
    
    func leftImage(image: UIImage?) {
        guard let image = image else { return }
        
        self.setImage(image, for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: image.size.width / 2)
        self.contentHorizontalAlignment = .left
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    func rightImage(image: UIImage?){
        guard let image = image else { return }
        
        self.setImage(image, for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left:image.size.width / 2, bottom: 0, right: 0)
        self.contentHorizontalAlignment = .right
        self.imageView?.contentMode = .scaleAspectFit
    }
}
