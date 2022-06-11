//
//  ApplyDetailView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/11.
//

class ApplyDetailView: BaseView {
    
    let progressBar = HorizontalBarChartView()
    
    override func setupProperty() {
        super.setupProperty()
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        progressBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
    }
}
