//
//  BlogViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/09.
//

import RIBs
import RxSwift
import UIKit
import WebKit

protocol BlogPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class BlogViewController: BaseNavigationViewController, BlogPresentable, BlogViewControllable {

    weak var listener: BlogPresentableListener?
    
    lazy var webView = WKWebView(frame: contentView.bounds)
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        showNavigationBar()
        setNavigationBarTitle("블로그")
        hideNavigationBarBackButton()
    }
    
    override func setupProperty() {
        super.setupProperty()
        webView.backgroundColor = .backgroundGray
        webView.scrollView.backgroundColor = .backgroundGray
        webView.isOpaque = false
        loadWebView(url: "https://atracker-web.netlify.app/")
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        contentView.addSubview(webView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        webView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Size.navigationBarHeight)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Size.tabBarHeight)
        }
    }
    
    func loadWebView(url: String) {
        webView.configuration.preferences.javaScriptEnabled = true
        if let url = URL(string: url) {
            webView.load(URLRequest(url: url))
        }
    }
}
