//
//  SignUpPositionViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import RIBs
import RxSwift
import RxGesture
import UIKit

protocol SignUpPositionPresentableAction: AnyObject {
    var tapBackButton: Observable<Void> { get }
    var tapNextButton: Observable<Void> { get }
    var tapExperienceTypeCell: Observable<ExperienceType> { get }
    var toggleExperienceTable: Observable<Bool> { get }
    var textJobPosition: Observable<String> { get }
    
}

protocol SignUpPositionPresentableHandler: AnyObject {
    var jobPosition: Observable<String> { get }
    var experienceType: Observable<ExperienceType> { get }
    var isSelectedNextButton: Observable<Bool> { get }
    var showExperienceTypeTable: Observable<Void> { get }
    var hideExperienceTypeTable: Observable<Void> { get }
}

protocol SignUpPositionPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    
//    func tapNextButton()
//    func tapCareerToggleButton()
//    func tapCareerTableView(career: String)
//    func inputPositionTextField(text: String)
//    func inputCareerTextField(text: String)
}

final class SignUpPositionViewController: BaseNavigationViewController, SignUpPositionPresentable, SignUpPositionViewControllable {
    
    weak var listener: SignUpPositionPresentableListener?
    weak var action: SignUpPositionPresentableAction? {
        return self
    }
    weak var handler: SignUpPositionPresentableHandler?
    
    let selfView = SignUpPositionView()
    
    private let tapExperienceTypeCellSubject = PublishSubject<ExperienceType>()
    private let toggleExperienceTableSubject = PublishSubject<Bool>()
    
    private let experienceTypes: [ExperienceType] = ExperienceType.list
    
    func switchCareerTableView() {
        let bool = !selfView.carrerTableView.isHidden
        selfView.carrerTableView.isHidden = bool
    }
    
    func updateCareerLabel(title: String) {
        selfView.careerUnderLineLabelView.contentLabel.text = title
        selfView.careerUnderLineLabelView.contentLabel.textColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selfView.carrerTableView.reloadData()
        refreshTableView(tableView: selfView.carrerTableView)
    }
    
    override func setupNavigaionBar() {
        super.setupNavigaionBar()
        showNavigationBar()
        hideNavigationBarShadow()
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
        
        guard let action = action else { return }
        guard let handler = handler else { return }

        selfView.careerUnderLineLabelView.rx.tapGesture()
            .bind { [weak self] tap in
                if tap.state == .ended {
                    self?.toggleExperienceTypeTable()
                }
            }
            .disposed(by: disposeBag)
        
        handler.experienceType
            .bind { [weak self] experienceType in
                self?.didUpdateExperienceType(experienceType: experienceType)
            }
            .disposed(by: disposeBag)
        
        handler.showExperienceTypeTable
            .bind { [weak self] in
                self?.selfView.carrerTableView.isHidden = false
            }
            .disposed(by: disposeBag)
        
        handler.hideExperienceTypeTable
            .bind { [weak self] in
                self?.selfView.carrerTableView.isHidden = true
            }
            .disposed(by: disposeBag)
        
//        selfView.bottomNextButtonView.button.rx.tap
//            .bind { [weak self] _ in
//                self?.listener?.tapNextButton()
//            }
//            .disposed(by: disposeBag)
//
//        selfView.positionUnderLineTextFieldView.textField.rx.text
//            .bind { [weak self] text in
//                if let text = text {
//                    self?.listener?.inputPositionTextField(text: text)
//                }
//            }
//            .disposed(by: disposeBag)
//
//        selfView.positionUnderLineTextFieldView.textField.rx.controlEvent([.editingDidBegin])
//            .asObservable()
//            .bind { [weak self] _ in
//                self?.selfView.positionUnderLineTextFieldView.isHighlight = true
//            }
//            .disposed(by: disposeBag)
//
//        selfView.positionUnderLineTextFieldView.textField.rx.controlEvent([.editingDidEnd])
//            .asObservable()
//            .bind { [weak self] _ in
//                self?.selfView.positionUnderLineTextFieldView.isHighlight = false
//            }
//            .disposed(by: disposeBag)
//
//        selfView.careerUnderLineLabelView.button.rx.tap
//            .bind { [weak self] _ in
//                self?.listener?.tapCareerToggleButton()
//            }
//            .disposed(by: disposeBag)
//
//        selfView.careerUnderLineLabelView.rx.tapGesture().bind {
//            [weak self] tap in
//            if tap.state == .ended {
//                self?.listener?.tapCareerToggleButton()
//            }
//        }
//        .disposed(by: disposeBag)
    }
    
    private func didUpdateExperienceType(experienceType: ExperienceType) {
        selfView.careerUnderLineLabelView.contentText = experienceType.title
    }
    
    private func toggleExperienceTypeTable() {
        let bool = selfView.carrerTableView.isHidden
        toggleExperienceTableSubject.onNext(!bool)
    }
}

extension SignUpPositionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return experienceTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTVC.id, for: indexPath) as? SearchTVC else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.update(title: experienceTypes[indexPath.item].title)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tapExperienceTypeCellSubject.onNext(experienceTypes[indexPath.item])
    }
}

extension SignUpPositionViewController: SignUpPositionPresentableAction {
    var tapNextButton: Observable<Void> {
        return selfView.bottomNextButtonView.button.rx.tap.asObservable()
    }
    
    var tapBackButton: Observable<Void> {
        return navigaionBar.backButton.rx.tap.asObservable()
    }
    
    var tapExperienceTypeCell: Observable<ExperienceType> {
        return tapExperienceTypeCellSubject.asObservable()
    }
    
    var toggleExperienceTable: Observable<Bool> {
        return toggleExperienceTableSubject.asObservable()
    }
    
    var textJobPosition: Observable<String> {
        return selfView.positionUnderLineTextFieldView.textField.rx.text.orEmpty.distinctUntilChanged().asObservable()
    }
}
