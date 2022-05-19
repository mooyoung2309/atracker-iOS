//
//  ApplicationReviewTableViewAdaptor.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/19.
//

import Foundation
import UIKit

class ApplicationReviewTableViewAdaptor: NSObject, UITableViewDelegate, UITableViewDataSource {
    weak var superVC: UIViewController!
    var typeMockUps: [String] = Const.Test.applicationTypeMockUps
    var contextMockUps: [[String]] = Const.Test.applicationContextMockUps
    
    init(_ superVC: UIViewController) {
        super.init()
        self.superVC = superVC
    }
//
//    func update(applicationProgress: [Application]) {
//        self.mockUps = mockUps
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return typeMockUps.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ApplicationReviewTableViewCell.identifier, for: indexPath) as! ApplicationReviewTableViewCell
        
        cell.update(type: typeMockUps[indexPath.section], contexts: contextMockUps[indexPath.section])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Log(indexPath)
        let applicationReviewEditVC = ApplicationReviewEditVC()
        applicationReviewEditVC.title = "우리은행 인턴"
        superVC.navigationController?.pushViewController(applicationReviewEditVC, animated: true)
    }
}
