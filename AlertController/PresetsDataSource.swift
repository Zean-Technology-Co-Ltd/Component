//
//  PresetsDataSource.swift
//  NiuNiuRent
//
//  Created by Q Z on 2023/4/27.
//

import SwiftEntryKit

struct PresetsDataSource {
    
    static var displayMode = EKAttributes.DisplayMode.inferred
    private var displayMode: EKAttributes.DisplayMode {
        return PresetsDataSource.displayMode
    }
    
    static func centerPresetsStyle(_ windowLevel: EKAttributes.WindowLevel = .normal,
                                   entryInteraction: EKAttributes.UserInteraction = .dismiss) -> EKAttributes{
        var attributes: EKAttributes
        attributes = .centerFloat
        attributes.displayMode = displayMode
        attributes.windowLevel = windowLevel
        attributes.displayDuration = .infinity
        attributes.hapticFeedbackType = .success
        attributes.screenBackground = .clear
        attributes.entryBackground = .clear
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = entryInteraction
        attributes.scroll = .disabled
        
        attributes.entranceAnimation = .init(
            scale: .init(
                from: 0.9,
                to: 1,
                duration: 0.4,
                spring: .init(damping: 0.8, initialVelocity: 0)
            ),
            fade: .init(
                from: 0,
                to: 1,
                duration: 0.3
            )
        )
        attributes.exitAnimation = .init(
            scale: .init(
                from: 1,
                to: 0.4,
                duration: 0.4,
                spring: .init(damping: 1, initialVelocity: 0)
            ),
            fade: .init(
                from: 1,
                to: 0,
                duration: 0.2
            )
        )
        attributes.shadow = .active(
            with: .init(
                color: .black,
                opacity: 0.2,
                radius: 6
            )
        )
        attributes.positionConstraints.size = .init(
            width: .constant(value: UIScreen.screenWidth),
            height: .constant(value: UIScreen.screenHeight)
        )
        return attributes
    }
    
    static func bottomPresetsStyle(action: (()->())?) -> EKAttributes{
        var attributes: EKAttributes
        attributes = .bottomFloat
        attributes.windowLevel = .normal
        attributes.displayMode = displayMode
        attributes.displayDuration = .infinity
        attributes.hapticFeedbackType = .success
        attributes.screenBackground = .clear
        attributes.entryBackground = .clear
        attributes.screenInteraction = .dismiss
        if let action = action {
            attributes.entryInteraction = .init(customTapActions: [action])
        } else {
            attributes.entryInteraction = .absorbTouches
        }
            
        attributes.scroll = .disabled
        attributes.roundCorners = .top(radius: 15)
        attributes.entranceAnimation = .init(
            translate: .init(
                duration: 0.5,
                spring: .init(damping: 1, initialVelocity: 0)
            )
        )
        attributes.exitAnimation = .init(
            translate: .init(duration: 0.35)
        )
        attributes.shadow = .active(
            with: .init(
                color: .black,
                opacity: 0.2,
                radius: 6
            )
        )
        attributes.positionConstraints.verticalOffset = 0
        attributes.positionConstraints.safeArea = .overridden
 
        attributes.positionConstraints.size = .init(
            width: .constant(value: UIScreen.screenWidth),
            height: .constant(value: UIScreen.screenHeight)
        )
        
        return attributes
    }
}

extension UIScreen {
    var minEdge: CGFloat {
        return UIScreen.main.bounds.minEdge
    }
}

extension CGRect {
    var minEdge: CGFloat {
        return min(width, height)
    }
}

