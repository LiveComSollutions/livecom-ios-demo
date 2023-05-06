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
        let theme = Appearence.AppTheme(
            primary: .white,
            secondary: .black,
            gradientFirst: .cyan,
            gradientSecond: .yellow
        )
        let appearence = Appearence(theme: theme)

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
