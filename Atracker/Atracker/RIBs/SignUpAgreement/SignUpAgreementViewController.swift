//
//  SignUpAgreementViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/19.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit

protocol SignUpAgreementPresentableAction: AnyObject {
    var tapBackButton: Observable<Void> { get }
    var tapNextButton: Observable<Void> { get }
    var tapServiceAgreementButton: Observable<Void> { get }
    var tapPersonalAgreementButton: Observable<Void> { get }
    var tapMarketingAgreementButton: Observable<Void> { get }
    var selectAllAgreement: Observable<Bool> { get }
    var selectServiceAgreement: Observable<Bool> { get }
    var selectPersonalAgreement: Observable<Bool> { get }
    var selectMarketingAgreement: Observable<Bool> { get }
}

protocol SignUpAgreementPresentableHandler: AnyObject {
    var isSelectedAllAgreement: Observable<Bool> { get }
    var isSelectedServiceAgreement: Observable<Bool> { get }
    var isSelectedPersonalAgreement: Observable<Bool> { get }
    var isSelectedMarketingAgreement: Observable<Bool> { get }
    var isSelectedNextButton: Observable<Bool> { get }
}

protocol SignUpAgreementPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class SignUpAgreementViewController: BaseNavigationViewController, SignUpAgreementPresentable, SignUpAgreementViewControllable {
    weak var listener: SignUpAgreementPresentableListener?
    
    weak var action: SignUpAgreementPresentableAction? {
        return self
    }
    weak var handler: SignUpAgreementPresentableHandler?
    
    let selfView = SignUpAgreementView()
    
    let selectAllAgreementSubject = BehaviorRelay<Bool>(value: false)
    let selectServiceAgreementSubject = BehaviorRelay<Bool>(value: false)
    let selectPersonalAgreementSubject = BehaviorRelay<Bool>(value: false)
    let selectMarketingAgreementSubject = BehaviorRelay<Bool>(value: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Log("뷰 디드 로드 호출 됨")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Log("뷰 디드 어피얼 호출됨")
    }
    
    override func setupNavigaionBar() {
        super.setupNavigaionBar()
        showNavigationBar()
        hideNavigationBarShadow()
    }
    
    override func setupProperty() {
        super.setupProperty()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        contentView.addSubview(selfView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        selfView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Size.navigationBarHeight)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func setupBind() {
        super.setupBind()
        guard let handler = handler else { return }
        guard let action = action else { return }

        // 바인딩 액션
        
        action.selectServiceAgreement
            .bind { [weak self] _ in
                
//                Log("[D] 뷰컨 \(handler.isSelectedServiceAgreement)")
//                Log("[D] 뷰컨 \(self?.selectAllAgreementSubject)")
            }
            .disposed(by: disposeBag)
        
        selfView.allAgreementView.leadingButton.rx.tap
            .bind { [weak self] in
                Log("[D] 뷰컨 올 리딩 버튼 탭 됌")
                self?.tapAllAgreement()
            }
            .disposed(by: disposeBag)
        
        selfView.serviceAgreementView.leadingButton.rx.tap
            .bind { [weak self] in
                self?.tapServiceAgreement()
            }
            .disposed(by: disposeBag)
        
        selfView.personalAgreementView.leadingButton.rx.tap
            .bind { [weak self] in
                self?.tapPersonalAgreement()
            }
            .disposed(by: disposeBag)
        
        selfView.marketingAgreementView.leadingButton.rx.tap
            .bind { [weak self] in
                self?.tapMarketingAgreement()
            }
            .disposed(by: disposeBag)
        
        // 바인딩 핸들러
        handler.isSelectedAllAgreement
            .bind { [weak self] bool in
                self?.selfView.allAgreementView.leadingButton.isSelected = bool
            }
            .disposed(by: disposeBag)
        
        handler.isSelectedServiceAgreement
            .bind { [weak self] bool in
                self?.selfView.serviceAgreementView.leadingButton.isSelected = bool
            }
            .disposed(by: disposeBag)
        
        handler.isSelectedPersonalAgreement
            .bind { [weak self] bool in
                self?.selfView.personalAgreementView.leadingButton.isSelected = bool
            }
            .disposed(by: disposeBag)
        
        handler.isSelectedMarketingAgreement
            .bind { [weak self] bool in
                self?.selfView.marketingAgreementView.leadingButton.isSelected = bool
            }
            .disposed(by: disposeBag)
        
        handler.isSelectedNextButton
            .bind { [weak self] bool in
                self?.selfView.nextButton.isSelected = bool
            }
            .disposed(by: disposeBag)
    }
    
    private func tapAllAgreement() {
        let bool = selfView.allAgreementView.leadingButton.isSelected
        selectAllAgreementSubject.accept(!bool)
        selectServiceAgreementSubject.accept(!bool)
        selectPersonalAgreementSubject.accept(!bool)
        selectMarketingAgreementSubject.accept(!bool)
    }
    
    private func tapServiceAgreement() {
        let bool = selfView.serviceAgreementView.leadingButton.isSelected
        selectServiceAgreementSubject.accept(!bool)
        if bool {
            selfView.allAgreementView.leadingButton.isSelected = false
        }
    }
    
    private func tapPersonalAgreement() {
        let bool = selfView.personalAgreementView.leadingButton.isSelected
        selectPersonalAgreementSubject.accept(!bool)
        if bool {
            selfView.allAgreementView.leadingButton.isSelected = false
        }
    }
    
    private func tapMarketingAgreement() {
        let bool = selfView.marketingAgreementView.leadingButton.isSelected
        selectMarketingAgreementSubject.accept(!bool)
        if bool {
            selfView.allAgreementView.leadingButton.isSelected = false
        }
    }
}

extension SignUpAgreementViewController: SignUpAgreementPresentableAction {
    var tapBackButton: Observable<Void> {
        return navigaionBar.backButton.rx.tap.asObservable()
    }
    
    var tapNextButton: Observable<Void> {
        return selfView.nextButton.rx.tap.asObservable()
    }
    
    var tapServiceAgreementButton: Observable<Void> {
        return selfView.serviceAgreementView.trailingButton.rx.tap.asObservable()
    }
    
    var tapPersonalAgreementButton: Observable<Void> {
        return selfView.personalAgreementView.trailingButton.rx.tap.asObservable()
    }
    
    var tapMarketingAgreementButton: Observable<Void> {
        return selfView.marketingAgreementView.trailingButton.rx.tap.asObservable()
    }
    
    var selectAllAgreement: Observable<Bool> {
        return selectAllAgreementSubject.asObservable()
    }
    
    var selectServiceAgreement: Observable<Bool> {
        return selectServiceAgreementSubject.asObservable()
    }
    
    var selectPersonalAgreement: Observable<Bool> {
        return selectPersonalAgreementSubject.asObservable()
    }
    
    var selectMarketingAgreement: Observable<Bool> {
        return selectMarketingAgreementSubject.asObservable()
    }
}
