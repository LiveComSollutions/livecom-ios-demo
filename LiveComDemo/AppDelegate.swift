//
//  AppDelegate.swift
//  LiveComApp
//

import UIKit
import LiveComSDK

let demoSDKKey = "f400270e-92bf-4df1-966c-9f33301095b3"

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window?.rootViewController = UIStoryboard(name: "Main", bundle: .main).instantiateInitialViewController()
        window?.makeKeyAndVisible()

        let brand = Appearence.AppTheme.Brand(
            primary: .white,
            secondary: .black,
            gradientFirst: .cyan,
            gradientSecond: .yellow
        )
        let theme = Appearence.AppTheme(brand: brand)
        let appearence = Appearence(theme: theme, cornerRadius: nil, font: nil)

        let sdkKey = UserDefaults.standard.string(forKey: "sdkKey") ?? demoSDKKey

        LiveCom.shared.configure(
            sdkKey: sdkKey,
            appearence: appearence,
            shareSettings: .init(
                videoLinkTemplate: "https://mysite.com/s/{video_id}",
                productLinkTemplate: "https://mysite.com/{video_id}?p={product_id}"
            )
        )
        return true
    }
}
