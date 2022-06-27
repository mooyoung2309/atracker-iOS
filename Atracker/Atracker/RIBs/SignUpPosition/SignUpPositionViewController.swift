//
//  SignUpPositionViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import RIBs
import RxSwift
import UIKit

protocol SignUpPositionPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    
    func tapNextButton()
    func tapCareerToggleButton()
    func inputPositionTextField(text: String)
    func inputCareerTextField(text: String)
}

final class SignUpPositionViewController: BaseNavigationViewController, SignUpPositionPresentable, SignUpPositionViewControllable {
    var thisView: UIView {
        return mainView
    }
    
    weak var listener: SignUpPositionPresentableListener?
    
    let selfView = SignUpPositionView()
    
    private var carrers = ["신입", "경력"]
    
    func switchCareerTableView() {
        let bool = !selfView.carrerTableView.isHidden
        selfView.carrerTableView.isHidden = bool
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selfView.carrerTableView.reloadData()
        refreshTableView(tableView: selfView.carrerTableView)
    }
    
    override func setupNavigaionBar() {
        super.setupNavigaionBar()
        
        hideNavigationBar()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        selfView.carrerTableView.delegate   = self
        selfView.carrerTableView.dataSource = self
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
        
        selfView.bottomNextButtonView.button.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapNextButton()
            }
            .disposed(by: disposeBag)
        
        selfView.positionUnderLineTextFieldView.textField.rx.text
            .bind { [weak self] text in
                if let text = text {
                    self?.listener?.inputPositionTextField(text: text)
                }
            }
            .disposed(by: disposeBag)
        
        selfView.positionUnderLineTextFieldView.textField.rx.controlEvent([.editingDidBegin])
            .asObservable()
            .bind { [weak self] _ in
                self?.selfView.positionUnderLineTextFieldView.isHighlight = true
            }
            .disposed(by: disposeBag)
        
        selfView.positionUnderLineTextFieldView.textField.rx.controlEvent([.editingDidEnd])
            .asObservable()
            .bind { [weak self] _ in
                self?.selfView.positionUnderLineTextFieldView.isHighlight = false
            }
            .disposed(by: disposeBag)
        
        selfView.careerUnderLineLabelView.button.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapCareerToggleButton()
            }
            .disposed(by: disposeBag)
    }
}

extension SignUpPositionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carrers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTVC.id, for: indexPath) as? SearchTVC else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.update(title: carrers[indexPath.item])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selfView.careerUnderLineLabelView.label.text = carrers[indexPath.item]
        selfView.careerUnderLineLabelView.label.textColor = .white
        switchCareerTableView()
    }
}
