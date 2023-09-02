//
//  PostsTableViewCell.swift
//  Posts_TestAssignment
//
//  Created by Maxym Bilyk on 01.09.2023.
//

import UIKit
import SnapKit

final class PostsTableViewCell: UITableViewCell {
    var onButtonClick: (() -> (Void))!
    
    var wrapView: UIView = {
        let view = UIView()
        return view
    }()
    
    var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 8.0
        stack.axis = .vertical
        return stack
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(hexString: Colors.title.name)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    var previewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(hexString: Colors.subTitle.name)
        label.textAlignment = .left
        label.numberOfLines = .min
        return label
    }()
    
    var likeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: Images.heart.name)
        image.tintColor = UIColor(hexString: Colors.accent.name)
        image.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        return image
    }()
    
    var likeTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(hexString: Colors.subTitle.name)
        label.textAlignment = .left
        return label
    }()
    
    var likeStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 4.0
        stack.axis = .horizontal
        return stack
    }()
    
    var calendarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: Images.calendar.name)
        image.tintColor = UIColor(hexString: Colors.calendar.name)
        return image
    }()
    
    var timeTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(hexString: Colors.subTitle.name)
        label.textAlignment = .left
        return label
    }()
    
    var dateStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 4.0
        stack.axis = .horizontal
        return stack
    }()
    
    var expandButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(hexString: Colors.title.name)
        button.addTarget(self, action: #selector(expandButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupWrapView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ model: PostModel, canBeExpanded: Bool, isExpanded: Bool) {
        titleLabel.text = model.title
        previewLabel.text = model.previewText
        likeTitle.text = "\(model.likesCount)"
        let formattedDate = model.timeshamp.getFormattedDate(format: "MM/dd/yyyy")
        timeTitle.text = "\(formattedDate)"
        expandButton.isHidden = !canBeExpanded
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hexString: Colors.plainText.name),
            .font: UIFont.systemFont(ofSize: 16)
        ]
        
        let attributedText = NSAttributedString(string: isExpanded ? "Show less" : "Show more", attributes: attributes)
        expandButton.setAttributedTitle(attributedText, for: .normal)
    }
    
    private func setupWrapView() {
        wrapView.layer.cornerRadius = 8.0
        wrapView.layer.borderWidth = 0.50
        wrapView.layer.borderColor = UIColor(hexString: Colors.plainText.name).withAlphaComponent(0.3).cgColor
        wrapView.clipsToBounds = false
    }
    
    private func setupLayout() {
        contentView.addSubview(wrapView)
        wrapView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4.0)
            make.leading.equalToSuperview().offset(8.0)
            make.trailing.equalToSuperview().inset(8.0)
            make.bottom.equalToSuperview().inset(4.0)
        }
        
        wrapView.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8.0)
            make.leading.equalToSuperview().offset(8.0)
            make.trailing.equalToSuperview().inset(8.0)
        }
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(previewLabel)
        
        wrapView.addSubview(likeStackView)
        likeStackView.snp.makeConstraints { make in
            make.top.equalTo(mainStackView.snp.bottom).offset(8.0)
            make.leading.equalToSuperview().offset(8.0)
            make.bottom.equalToSuperview().inset(8.0)
        }
        
        likeStackView.addArrangedSubview(likeImage)
        likeStackView.addArrangedSubview(likeTitle)
        
        wrapView.addSubview(dateStackView)
        dateStackView.snp.makeConstraints { make in
            make.top.equalTo(mainStackView.snp.bottom).offset(8.0)
            make.leading.equalTo(likeStackView.snp.trailing).offset(8.0)
            make.bottom.equalToSuperview().inset(8.0)
        }
        
        dateStackView.addArrangedSubview(calendarImage)
        dateStackView.addArrangedSubview(timeTitle)
        
        wrapView.addSubview(expandButton)
        expandButton.snp.makeConstraints { make in
            make.top.equalTo(mainStackView.snp.bottom).offset(6.0)
            make.leading.equalTo(dateStackView.snp.trailing).offset(8.0)
            make.bottom.equalToSuperview().inset(6.0)
        }
    }
    
    @objc private func expandButtonTapped() {
        onButtonClick()
    }
}
