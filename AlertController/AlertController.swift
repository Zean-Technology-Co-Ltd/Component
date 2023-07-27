//
//  AlertController.swift
//  NiuNiuRent
//
//  Created by Q Z on 2023/4/27.
//

import UIKit
import SwiftEntryKit

class AlertController: NSObject {
    class func showAlertViewWith(_ target: UIViewController,
                                 title: String,
                                 message: String,
                                 leftBtnTitle: String = "取消",
                                 rightBtnTitle: String,
                                 completion: @escaping ((Bool)->())){
        let alertVc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancleAlert = UIAlertAction(title: leftBtnTitle, style: .cancel){_ in
            completion(false)
        }
        let okAlert = UIAlertAction(title: rightBtnTitle, style: .default){_ in
            completion(true)
        }
        alertVc.addAction(cancleAlert)
        alertVc.addAction(okAlert)
        target.present(alertVc, animated: true)
    }
    
    class func nn_CustomViewWith(_ onViewController: UIViewController,
                                       title: String? = nil,
                                       content: String,
                                       contentAttribute: NSMutableAttributedString? = nil,
                                       leftBtnTitle: String? = nil,
                                       rightBtnTitle: String,
                                 completion: ((Bool)->())?){
        let viewController = AlertContentVC(title, content: content, contentAttribute: contentAttribute, leftTitle: leftBtnTitle, rightTitle: rightBtnTitle, completion: completion)
        let style = PresetsDataSource.centerPresetsStyle(.alerts, entryInteraction: .absorbTouches)
        SwiftEntryKit.display(entry: viewController, using: style)
    }
    
    class func dismiss(){
        SwiftEntryKit.dismiss()
    }
    
    class func layoutConstraint(superView: UIView,
                                targetView: UIView,
                                leadingAnchor: CGFloat,
                                trailingAnchor: CGFloat,
                                topAnchor: CGFloat,
                                bottomAnchor: CGFloat){
        targetView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            targetView.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: leadingAnchor),
            targetView.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: trailingAnchor),
            targetView.topAnchor.constraint(equalTo: superView.topAnchor, constant: topAnchor),
            targetView.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: bottomAnchor)
        ])
    }
    
    class func layoutConstraint(targetView: UIView,
                                width: CGFloat,
                                height: CGFloat){
        targetView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            targetView.widthAnchor.constraint(equalToConstant: width),
            targetView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
