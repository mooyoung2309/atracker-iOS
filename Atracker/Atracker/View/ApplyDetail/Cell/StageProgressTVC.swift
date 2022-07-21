//
//  StageProgressTVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/15.
//

import UIKit

class StageProgressTVC: BaseTVC {
    static let id = "StageProgressTVC"
    
    let circle = UIView()
    let titleLabel = UILabel()
    let contentStackView = UIStackView()
    let divider = Divider(.white)
    
    func update(stageProgress: StageProgress) {
        prepareForReuse()
        
        titleLabel.text = stageProgress.stageTitle
        
        circle.backgroundColor = .progressColors[stageProgress.order]
        
        divider.update(.progressColors[stageProgress.order])
        
        for stageContent in stageProgress.stageContents {
            switch stageContent.contentType {
            case StageContentType.OVERALL.code:
                let overallContentView = OVERALLContentView(overallContent: ContentSerialization.shared.toOVERALLContent(string: stageContent.content))
                
                contentStackView.addArrangedSubview(overallContentView)
            case StageContentType.FREE.code:
                let freeContentView = FREEContentView(freeContent: ContentSerialization.shared.toFreeContent(string: stageContent.content))
                
                contentStackView.addArrangedSubview(freeContentView)
            case StageContentType.QNA.code:
                let qnaContentView = QNAContentView(qnaContent: ContentSerialization.shared.toQNAContent(string: stageContent.content))
                
                contentStackView.addArrangedSubview(qnaContentView)
            default:
                let overallContentView = OVERALLContentView(overallContent: ContentSerialization.shared.toOVERALLContent(string: stageContent.content))
                
                contentStackView.addArrangedSubview(overallContentView)
                break
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        contentStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .clear
        
        circle.layer.cornerRadius = 4
        
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 18, weight: .regular)
        
        contentStackView.axis = .vertical
        contentStackView.spacing = 68
        contentStackView.distribution = .equalSpacing
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(circle)
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentStackView)
        contentView.addSubview(divider)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        circle.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(21)
            $0.centerY.equalTo(titleLabel)
            $0.width.height.equalTo(8)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(34)
            $0.leading.equalTo(circle.snp.trailing).inset(-9)
        }
        
        contentStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        divider.snp.makeConstraints {
            $0.top.equalTo(contentStackView.snp.bottom).inset(-34)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
