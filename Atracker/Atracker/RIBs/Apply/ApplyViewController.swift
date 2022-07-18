//
//  ApplyViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/03.
//

import RIBs
import RxSwift
import UIKit

protocol ApplyPresentableAction: AnyObject {
    var tapPlusButton: Observable<Void> { get }
    var tapMyPageButton: Observable<Void> { get }
    var tapApplyTVC: Observable<Apply> { get }
}

protocol ApplyPresentableHandler: AnyObject {
    var applies: Observable<[Apply]> { get }
}

protocol ApplyPresentableListener: AnyObject {
    
}

final class ApplyViewController: BaseNavigationViewController, ApplyPresentable, ApplyViewControllable {
    weak var listener: ApplyPresentableListener?
    
    weak var action: ApplyPresentableAction? {
        return self
    }
    weak var handler: ApplyPresentableHandler?
    
    let selfView = ApplyView()
    
    private let tapApplyTVCSubject = PublishSubject<Apply>()
    
    private var applies: [Apply] = []
    
    override func setupNavigaionBar() {
        super.setupNavigaionBar()
        
        setNavigaionBarTitle("지원 현황")
        hideNavigationBarBackButton()
        hideNavigationBar()
    }
    
    override func setupReload() {
        super.setupReload()
        
        view.backgroundColor = .backgroundGray
        refreshTableView(tableView: selfView.applyTableView)
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        selfView.applyTableView.delegate = self
        selfView.applyTableView.dataSource = self
        selfView.scrollView.delegate = self
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(selfView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        selfView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Size.tabBarHeight)
        }
    }
    
    override func setupBind() {
        super.setupBind()
        
        guard let action = action else { return }
        guard let handler = handler else { return }
        
        handler.applies
            .bind { [weak self] applies in
                self?.reloadApplyTableView(applies: applies)
            }
            .disposed(by: disposeBag)
    }
    
    func reloadApplyTableView(applies: [Apply]) {
        self.applies = applies
        
        selfView.applyTableView.reloadData()
        refreshTableView(tableView: selfView.applyTableView)
    }
}

extension ApplyViewController: ApplyPresentableAction {
    var tapApplyTVC: Observable<Apply> {
        return tapApplyTVCSubject.asObservable()
    }
    
    var tapPlusButton: Observable<Void> {
        return selfView.plusButton.rx.tap.asObservable()
    }
    
    var tapMyPageButton: Observable<Void> {
        return selfView.myPageButton.rx.tap.asObservable()
    }
}

extension ApplyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return applies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case selfView.applyTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ApplyTVC.id, for: indexPath) as? ApplyTVC else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            cell.update(apply: applies[indexPath.row])
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tapApplyTVCSubject.onNext(applies[indexPath.item])
    }
}

extension ApplyViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= Size.navigationBarHeight {
            showNavigationBar()
        } else {
            hideNavigationBar()
        }
    }
}
