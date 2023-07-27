//
//  NNNavigationController.swift
//  NiuNiuRent
//
//  Created by 张泉 on 2023/4/18.
//

import UIKit

class NNNavigationController: UINavigationController {
    private var navBarHiddenVCList = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        navBarHiddenVCList = [
            "NiuNiuRent.NNHomeViewController".lowercased(),
//            "NiuNiuRent.NNMineViewController".lowercased(),
            "NiuNiuRent.NNRecommendListVC".lowercased(),
        ]
        
        UINavigationBar.appearance().tintColor = UIColor(hex: "#262626")
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barStyle = .default
        UINavigationBar.appearance().setBackgroundImage( UIImage.imageWithColor(color: .white), for: .default)
        
        let navbarTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(hex: "#262626"),
            NSAttributedString.Key.font: UIFont.medium(16)
        ]
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.white
            appearance.shadowImage = UIImage.imageWithColor(color: .backgroundColor)
            appearance.titleTextAttributes = navbarTitleTextAttributes
            let backButtonAppearance = UIBarButtonItemAppearance()
            backButtonAppearance.normal.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.clear]
            appearance.backButtonAppearance = backButtonAppearance
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().shadowImage = UIImage()
            UINavigationBar.appearance().backIndicatorTransitionMaskImage = R.image.common_arrow_pop_icon()?.withRenderingMode(.alwaysOriginal)
            UINavigationBar.appearance().backIndicatorImage = R.image.common_arrow_pop_icon()?.withRenderingMode(.alwaysOriginal)
            UINavigationBar.appearance().titleTextAttributes = navbarTitleTextAttributes
            UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000, vertical: 0), for: .default)
        }
        
        
    }
    
}

extension NNNavigationController: UINavigationControllerDelegate{
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = self.viewControllers.count > 0
        super.pushViewController(viewController, animated: animated)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let vc_name = String(utf8String: object_getClassName(viewController))?.lowercased() ?? ""
        if self.navBarHiddenVCList.contains(vc_name){
            navigationController.setNavigationBarHidden(true, animated: animated)
        } else {
            navigationController.setNavigationBarHidden(false, animated: animated)
        }
    }
}
