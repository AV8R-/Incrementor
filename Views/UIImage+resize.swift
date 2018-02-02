//
//  UIImage+resize.swift
//  Views
//
//  Created by Богдан Маншилин on 02/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

extension UIImage {
    enum ScaleMode {
        case contentFill
        case contentAspectFill
        case contentAspectFit
    }
    
    private func resizeImage(withSize size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func resizeImage(withSize size: CGSize, scaleMode: ScaleMode = .contentAspectFill) -> UIImage? {
        let aspectWidth = size.width / self.size.width;
        let aspectHeight = size.height / self.size.height;
        
        switch scaleMode {
        case .contentFill:
            return resizeImage(withSize: size)
        case .contentAspectFit:
            let aspectRatio = min(aspectWidth, aspectHeight)
            return resizeImage(withSize: CGSize(width: self.size.width * aspectRatio, height: self.size.height * aspectRatio))
        case .contentAspectFill:
            let aspectRatio = max(aspectWidth, aspectHeight)
            return resizeImage(withSize: CGSize(width: self.size.width * aspectRatio, height: self.size.height * aspectRatio))
        }
    }
}
