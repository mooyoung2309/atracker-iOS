//
//  ApplicationProgressTableViewAdaptor.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/18.
//

import UIKit

class ApplicationProgressTableViewAdaptor: NSObject, UITableViewDelegate, UITableViewDataSource {
    weak var superVC: UIViewController!
    var applications: [Application] = []
    
    init(_ superVC: UIViewController) {
        super.init()
        self.superVC = superVC
    }
    
    func update(applicationProgress: [Application]) {
        self.applications = applicationProgress
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return applications.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ApplicationProgressTableViewCell.identifier, for: indexPath) as! ApplicationProgressTableViewCell
        
        cell.update(applicationProgress: applications[indexPath.section])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        superVC.navigationController?.pushViewController(ApplicationReviewVC(application: applications[indexPath.section]), animated: true)
    }
}
