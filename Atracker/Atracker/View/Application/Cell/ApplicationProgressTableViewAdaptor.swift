//
//  ApplicationProgressTableViewAdaptor.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/18.
//

import UIKit

class ApplicationProgressTableViewAdaptor: NSObject, UITableViewDelegate, UITableViewDataSource {
    var applicationProgresses: [ApplicationProgress] = []
    
    func update(applicationProgress: [ApplicationProgress]) {
        self.applicationProgresses = applicationProgress
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return applicationProgresses.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ApplicationProgressTableViewCell.identifier, for: indexPath) as! ApplicationProgressTableViewCell
        
        cell.update(applicationProgress: applicationProgresses[indexPath.section])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Log(indexPath)
    }
}
