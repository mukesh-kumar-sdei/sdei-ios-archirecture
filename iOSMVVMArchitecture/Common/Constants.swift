//
//  Constants.swift
//  iOSMVVMArchitecture
//
//  Created by Amit Shukla on 13/01/20.
//  Copyright © 2020 smartData Enterprises (I) Ltd. All rights reserved.
//

import Foundation
import UIKit

enum Screen {
    static let width     = UIScreen.main.bounds.size.width
    static let height    = UIScreen.main.bounds.size.height
    static let scale     = UIScreen.main.scale
}
// MARK: Color
// Declare all all hex colors here
// Example: self.view.backgroundColor = AppColor.backgroundColor
enum Color {
    static let Primary       = UIColor("#2D79B9")
    static let Secondary     = UIColor("#42B3B5")
    static let Button        = UIColor("#33AFFF")
    static let LightGray     = UIColor("#333333")
    static let DarkGray      = UIColor("#666565")
    static let Line          = UIColor(666565, alpha: 0.2)
}

// MARK: Font
// Declare all all fonts here
// Example: something.font = AppFont.Regular.of(1024)
enum Font: String {
  case Regular = "Poppins-Regular"
  case Medium  = "Poppins-Medium"
  case Bold  = "Poppins-Bold"
  func of(size: CGFloat) -> UIFont {
    return UIFont(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
  }
}

// MARK: Key
// Declare all keys here.
enum Key {

    static let DeviceType = "iOS"
    enum Beacon {
        static let ONEXUUID = "xxxx-xxxx-xxxx-xxxx"
    }

    enum UserDefaults {
        static let k_App_Running_FirstTime = "userRunningAppFirstTime"
    }

    enum Headers {
        static let Authorization = "Authorization"
        static let ContentType = "Content-Type"
    }
    enum Google {
        static let placesKey = "some key here"//for photos
        static let serverKey = "some key here"
    }
    enum Params {
        static let name = "name"
        static let email = "email"
        static let password = "password"
        static let id = "id"
        
    }
}

// MARK: AlertMessage
// Declare all all alert messages here
// Example: invalidURL.localized
enum AlertMessage {
     static let invalidURL       = "Invalid server url"
     static let lostInternet     = "It seems you are offline, Please check your Internet connection."
     static let invalidEmail     = "Please enter a valid email address"
     static let invalidPassword  = "Please enter a minimum 6 character password"
}

// MARK: Notification.Name
// Declare all notifications name here
// Example: NotificationCenter.default.post(name: .customNotification, object: nil)
extension Notification.Name {
    // Notifications
    static let customNotification = Notification.Name("customNotification")
}

// MARK: Storyboard
// Declare all storyboards name here
// Example: -
enum Storyboard: String {
   case Main = "Main"
   case Dashboard = "Dashboard"
}

// MARK: ReuseIdentifier
// Declare all Cell reuseidentifier here
// Example: -
enum ReuseIdentifier {
    static let HomeCollectionViewCell   = "HomeCollectionViewCell"
    static let ResidentTableViewCell    = "ResidentTableViewCell"
    static let ListTableViewCell        = "ListTableViewCell"
    static let VitalHistoryTableViewCell = "VitalHistoryTableViewCell"
    
}

// MARK: NavigationTitle
// Declare all navigation titles here
// Example: -
enum NavigationTitle {
    static let Home = "Home"
    static let Dashboard = "Dashboard"
    static let MyTask = "My Tasks"
    static let Resident = "Resident"
    static let Settings = "Setting"
    static let ResidentDetail = "Resident Detail"
    static let VitalHistory = "Vital History"
}
