//
//  NNButton.swift
//  NiuNiuRent
//
//  Created by 张泉 on 2023/4/20.
//

import UIKit

class NNButton: UIButton {
    var titleRect = CGRect.zero
    var imageRect = CGRect.zero
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        if imageRect == .zero {
            return super.imageRect(forContentRect: contentRect)
        } else {
            return imageRect
        }
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        if titleRect == .zero {
            return super.titleRect(forContentRect: contentRect)
        } else {
            return titleRect
        }
    }
}
