//
//  EditApplyOverallViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/05.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol EditApplyOverallPresentableAction: AnyObject {
    var tapBackButton: Observable<Void> { get }
}

protocol EditApplyOverallPresentableHandler: AnyObject {

}

protocol EditApplyOverallPresentableListener: AnyObject {
    
}

final class EditApplyOverallViewController: BaseNavigationViewController, EditApplyOverallPresentable, EditApplyOverallViewControllable {
    
    weak var listener: EditApplyOverallPresentableListener?
    
    var action: EditApplyOverallPresentableAction? {
        return self
    }
    
    var handler: EditApplyOverallPresentableHandler?
    
    
    private let selfView = EditApplyOverallView()
    private var stages = ["서류", "1차면접", "2차면접", "3차면접"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selfView.stageTableView.reloadData()
        refreshTableView(tableView: selfView.stageTableView)
        selfView.showStageCircle(max: stages.count)
    }
    
    override func setupNavigaionBar() {
        super.setupNavigaionBar()
        
        setNavigaionBarTitle("지원 현황 편집")
        showNavigationBarBackButton()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        selfView.stageTableView.delegate = self
        selfView.stageTableView.dataSource = self
        selfView.stageTableView.dragInteractionEnabled = true
        selfView.stageTableView.dragDelegate = self
        selfView.stageTableView.dropDelegate = self
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
        
    }
}

extension EditApplyOverallViewController: EditApplyOverallPresentableAction {
    var tapBackButton: Observable<Void> {
        return navigaionBar.backButton.rx.tap.asObservable()
    }
}

extension EditApplyOverallViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate, UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        Log("[D] \(dragItem)")
        return [ dragItem ]
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        Log("[D] \(coordinator.items)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DraggableStageTVC.id, for: indexPath) as? DraggableStageTVC else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        
        if indexPath.row == 0 {
            cell.containerView.layer.cornerRadius = 10
            cell.containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else if indexPath.row == stages.count - 1 {
            cell.containerView.layer.cornerRadius = 10
            cell.containerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        
        cell.update(title: stages[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("[D] \(sourceIndexPath.row) -> \(destinationIndexPath.row)")
        let moveCell = self.stages[sourceIndexPath.row]
        self.stages.remove(at: sourceIndexPath.row)
        self.stages.insert(moveCell, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, dragPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        
        let param = UIDragPreviewParameters()
        param.backgroundColor = .clear
        return param
    }
    
    func tableView(_ tableView: UITableView, dropPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        
        let param = UIDragPreviewParameters()
        param.backgroundColor = .clear
        return param
    }
    
}
