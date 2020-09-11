//
//  AppDelegate.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/17/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import IQKeyboardManager
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //IQKeyboardManage
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        //Firebase
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        } else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }
        Messaging.messaging().delegate = self
        application.registerForRemoteNotifications()


        FirebaseApp.configure()
        
        //Get fireBase token
        InstanceID.instanceID().instanceID { (result, error) in
          if let error = error {
            print("Error fetching remote instance ID: \(error)")
          } else if let result = result {
            driveToken = result.token
            print("Remote instance ID token: \(result.token)")
          }
        }
        //Check authToken and Remember me
        let rememberMe = defaults.bool(forKey: REMEMBER_ME_KEY)
        let authToken = defaults.string(forKey: TOKEN_KEY)
        if rememberMe == false{
            let mainStoryboardIpad:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewControlleripad = mainStoryboardIpad.instantiateViewController(withIdentifier: "welcomeVC") as UIViewController
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = initialViewControlleripad
            self.window?.makeKeyAndVisible()
        }else if rememberMe == true{
            guard let authToken = authToken else {return true}
            AuthService.instan.getMe(authToken: authToken) { (success, userInfo, errorCode) in
                if success{
                    if errorCode == 400 {
                        let mainStoryboardIpad:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let initialViewControlleripad = mainStoryboardIpad.instantiateViewController(withIdentifier: "signInVC") as UIViewController
                        self.window = UIWindow(frame: UIScreen.main.bounds)
                        self.window?.rootViewController = initialViewControlleripad
                        self.window?.makeKeyAndVisible()
                    }else{
                        let mainStoryboardIpad:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let initialViewControlleripad = mainStoryboardIpad.instantiateViewController(withIdentifier: "dashboardVC") as UIViewController
                        self.window = UIWindow(frame: UIScreen.main.bounds)
                        self.window?.rootViewController = initialViewControlleripad
                        self.window?.makeKeyAndVisible()
                    }
                }
            }
        }
        
        
        
        return true
    }
    // the FCM registration token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        guard let token = String(data: deviceToken, encoding: String.Encoding.ascii) else {return}
        print("APNs token retrieved: \(token)")

      // With swizzling disabled you must set the APNs token here.
      // Messaging.messaging().apnsToken = deviceToken
    }

    // MARK: UISceneSession Lifecycle
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    //
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification

      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)

      // Print message ID.
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      // Print full message.
      print(userInfo)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification

      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)

      // Print message ID.
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      // Print full message.
      print(userInfo)

      completionHandler(UIBackgroundFetchResult.newData)
    }

}
extension AppDelegate:MessagingDelegate{
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
      print("Firebase registration token: \(fcmToken)")

      let dataDict:[String: String] = ["token": fcmToken]
      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }
    // Get message body from notication
    if let activity = userInfo["activity"] as? String {
        if activity == "confirm_code"{
            if let dataNotif = userInfo["data"] as? String {
                let data = dataNotif.data(using: .utf8)!
                do{
                    let output = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                    if let dataCode = output!["data"] as? Dictionary<String,AnyObject> {
                        if let code = dataCode["code"] as? Int{
                            messageCodeFromNotif = code
                            NotificationCenter.default.post(name: NOTIF_MESSAGE_CODE_DATA_DID_CHANGE, object: nil)
                            print(code)
                        }
                    }
                }catch{
                    print(error)
                }
            }
        }
    }
    
        
    //let code = dataCode["code"] as! String
//    messageFromNotif = code
//    print(messageFromNotif)
    // Print full message.
    print(userInfo)

    // Change this to your preferred presentation option
    completionHandler([[.alert, .sound]])
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo
    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print full message.
    print(userInfo)

    completionHandler()
  }
}


