//
//  BeautyDictionaryTableViewCell.swift
//  Sisters Staging
//
//  Created by Developer on 03.08.2023.
//

import UIKit

class BeautyDictionaryTableViewCell: UITableViewCell {
    
    var onButtonClick: (() -> (Void))!
    
    private let stackView = UIStackView()
    private let title = UILabel()
    private let containerView = UIStackView()
    let subtitle = UILabel()
    private let button = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        configureStackView()
        configureTitle()
        configureContainerView()
        configureSubtitle()
        configureButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupModel(_ model: BeautyDictionaryTableViewCellModel, canBeExpanded: Bool, isExpanded: Bool) {
        title.text = model.title
        subtitle.text = model.subtitle
        button.isHidden = !canBeExpanded

        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: R.color.mainGreen(),
            .font: UIFont.systemFont(ofSize: 12)
        ]

        let attributedText = NSAttributedString(string: isExpanded ? "Згорнути" : "Дізнатись більше", attributes: attributes)
        button.setAttributedTitle(attributedText, for: .normal)
    }
    
    private func configureStackView() {
        contentView.addSubview(stackView)
        stackView.spacing = 10.0
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
    
    private func configureTitle() {
        stackView.addArrangedSubview(title)
        title.font = .systemFont(ofSize: 16.0)
        title.numberOfLines = 1
        title.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
    }
    
    private func configureContainerView() {
        stackView.addArrangedSubview(containerView)
        containerView.distribution = .fill
        containerView.alignment = .leading
        containerView.axis = .vertical
        containerView.spacing = 4
    }
    
    private func configureSubtitle() {
        containerView.addArrangedSubview(subtitle)
        subtitle.numberOfLines = .min
        subtitle.textColor = R.color.greyDark()
        subtitle.font = .systemFont(ofSize: 14.0)
    }
    
    private func configureButton() {
        containerView.addArrangedSubview(button)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
    }
    
    @objc func buttonTapped() {
        onButtonClick()
    }
}

