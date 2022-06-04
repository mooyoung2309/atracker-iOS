//
//  RootComponent+LoggedIn.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/03.
//

import RIBs

protocol RootDependencyLoggedIn: Dependency {
    
}

extension RootComponent: LoggedInDependency {
    var LoggedInViewController: LoggedInViewControllable {
        return rootViewController
    }
}
