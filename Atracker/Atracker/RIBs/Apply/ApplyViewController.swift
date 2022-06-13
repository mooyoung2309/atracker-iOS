//
//  ApplyViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/03.
//

import RIBs
import RxSwift
import UIKit

protocol ApplyPresentableListener: AnyObject {
    func didTabCell(apply: Apply)
}

final class ApplyViewController: BaseNavigationViewController, ApplyPresentable, ApplyViewControllable {
    
    var contentView: UIView {
        return self.mainView
    }
    weak var listener: ApplyPresentableListener?
    
    let selfView = ApplyView()
    
    let mockUps = ["이소진 1", "이소진 2", "이소진 3", "이소진 4", "이소진 5", "이소진 6", "이소진 7", "이소진 8"]
    
    private var applyList: [Apply] = []
    
    func present(viewController: ViewControllable) {
        present(viewController.uiviewController, animated: true, completion: nil)
    }
    
    func showApplyList(_ applyList: [Apply]) {
        self.applyList = applyList
        selfView.tableView.reloadData()
        refreshTableView(tableView: selfView.tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavigaionBarBackButton(false)
    }
    
    override func setupReload() {
        view.backgroundColor = .backgroundGray
        
        refreshTableView(tableView: selfView.tableView)
    }
    
    override func setupProperty() {
        super.setupProperty()
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self
        selfView.scrollView.delegate = self
        
        setNavigaionBarTitle("지원 현황")
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        mainContentView.addSubview(selfView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        selfView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func setupBind() {
        super.setupBind()
//        selfView.plusButton.rx.tap
//        .bind { [weak self] _ in
//            self?.listener?.didTabApplyEdit()
//        }
//        .disposed(by: disposeBag)
    }
}

extension ApplyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return applyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case selfView.tableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ApplyProgressTVC.id, for: indexPath) as? ApplyProgressTVC else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            cell.update(apply: applyList[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Log(applyList[indexPath.row])
        self.listener?.didTabCell(apply: applyList[indexPath.row])
    }
}

extension ApplyViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= Size.navigationBarHeight {
            showNavigaionBar(true)
        } else {
            showNavigaionBar(false)
        }
    }
}
