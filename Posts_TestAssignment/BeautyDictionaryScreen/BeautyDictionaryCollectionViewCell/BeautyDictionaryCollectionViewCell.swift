//
//  BeautyDictionaryCollectionViewCell.swift
//  Sisters Staging
//
//  Created by Developer on 03.08.2023.
//

import UIKit

class BeautyDictionaryCollectionViewCell: UICollectionViewCell {
    
    var onButtonClick: (() -> (Void))!
    
    let background = UIView()
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBackground()
        configureTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupModel(_ model: BeautyDictionaryCollectionViewCellModel, isActive: Bool) {
        title.text = model.title
        background.layer.borderColor = isActive ? R.color.mainGreen()?.cgColor : R.color.white()?.cgColor
    }
    
    private func configureBackground() {
        contentView.addSubview(background)
        background.backgroundColor = UIColor.white
        background.layer.cornerRadius = 12
        background.layer.borderWidth = 1
        background.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }

    private func configureTitle() {
        background.addSubview(title)
        title.font = .systemFont(ofSize: 12)
        title.snp.makeConstraints { make in
            make.top.equalTo(background.snp.top).offset(7)
            make.left.equalTo(contentView.snp.left).offset(16)
            make.right.equalTo(contentView.snp.right).offset(-16)
            make.bottom.equalTo(background.snp.bottom).offset(-7)
        }
    }
}

