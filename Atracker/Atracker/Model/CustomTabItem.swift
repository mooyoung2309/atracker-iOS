//
//  CustomTabItem.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/23.
//

import UIKit

enum CustomTabItem: String, CaseIterable {
    case blog
    case application
    case calendar
}
 
extension CustomTabItem {
    var viewController: UIViewController {
        switch self {
        case .blog:
            return UINavigationController(rootViewController: BlogViewController())
        case .application:
            return UINavigationController(rootViewController: ApplyVC())
        case .calendar:
            return UINavigationController(rootViewController: ScheduleVC())
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .blog:
            return UIImage(systemName: "magnifyingglass.circle")?.withTintColor(.white.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
        case .application:
            return UIImage(systemName: "heart.circle")?.withTintColor(.white.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
        case .calendar:
            return UIImage(systemName: "person.crop.circle")?.withTintColor(.white.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
        }
    }
    
    var selectedIcon: UIImage? {
        switch self {
        case .blog:
            return UIImage(systemName: "magnifyingglass.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .application:
            return UIImage(systemName: "heart.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .calendar:
            return UIImage(systemName: "person.crop.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        }
    }
    
    var name: String {
        return self.rawValue.capitalized
    }
}
