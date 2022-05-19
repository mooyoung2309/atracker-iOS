//
//  MainViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/18.
//

import UIKit

class MainViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        let blogTap = UINavigationController(rootViewController: BlogViewController())
        let blogTapBarItem = UITabBarItem(title: "블로그", image: UIImage(systemName: "doc"), selectedImage: UIImage(named: "doc"))
        
        let applicationStatusTap = UINavigationController(rootViewController: ApplicationVC())
        let applicationStatusTapBarItem = UITabBarItem(title: "지원 현황", image: UIImage(systemName: "house"), selectedImage: UIImage(named: "house"))
        
        let scheduleCalendarTap = UINavigationController(rootViewController: CalendarVC())
        let scheduleCalendarTapBarItem = UITabBarItem(title: "일정", image: UIImage(systemName: "calendar"), selectedImage: UIImage(named: "calendar"))
        
        
        blogTap.tabBarItem = blogTapBarItem
        applicationStatusTap.tabBarItem = applicationStatusTapBarItem
        scheduleCalendarTap.tabBarItem = scheduleCalendarTapBarItem

        
        self.viewControllers = [blogTap, applicationStatusTap, scheduleCalendarTap]
        self.selectedIndex = 2
    }
}
