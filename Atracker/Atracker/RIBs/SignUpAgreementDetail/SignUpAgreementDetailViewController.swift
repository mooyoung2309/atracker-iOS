//
//  SignUpAgreementDetailViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/24.
//

import RIBs
import RxSwift
import UIKit
import WebKit

protocol SignUpAgreementDetailPresentableListener: AnyObject {
    func tapBackButton()
}

final class SignUpAgreementDetailViewController: BaseNavigationViewController, SignUpAgreementDetailPresentable, SignUpAgreementDetailViewControllable {

    weak var listener: SignUpAgreementDetailPresentableListener?
    
    let webView = WKWebView()
    
    override func setupNavigaionBar() {
        super.setupNavigaionBar()
        showNavigationBarBackButton()
    }
    
    override func setupProperty() {
        super.setupProperty()
        webView.backgroundColor = .backgroundGray
        webView.scrollView.backgroundColor = .backgroundGray
        webView.isOpaque = false
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
            $0.bottom.equalToSuperview()
        }
    }
    
    override func setupBind() {
        super.setupBind()
        navigaionBar.backButton.rx.tap
            .bind { [weak self] in
                self?.listener?.tapBackButton()
            }
            .disposed(by: disposeBag)
    }
    
    func loadWebView(url: String) {
        webView.configuration.preferences.javaScriptEnabled = true
        if let url = URL(string: url) {
            webView.load(URLRequest(url: url))
        }
    }
}
