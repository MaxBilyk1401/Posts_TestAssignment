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
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        return stack
    }()
    
    var textStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 8.0
        stack.axis = .vertical
        return stack
    }()
    
    var lowerStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 8.0
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(hexString: Colors.title.name)
        label.textAlignment = .left
        label.numberOfLines = .min
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
        stack.distribution = .fill
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
        stack.distribution = .fill
        return stack
    }()
    
    var expandButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(hexString: Colors.title.name)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        expandButton.addTarget(self, action: #selector(expandButtonTapped), for: .touchUpInside)
        setupWrapView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ model: PostsModel, canBeExpanded: Bool, isExpanded: Bool) {
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
            make.bottom.equalToSuperview().inset(8.0)
        }
        
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(previewLabel)
        
        mainStackView.addArrangedSubview(textStackView)
        mainStackView.addArrangedSubview(lowerStackView)
        
        
        lowerStackView.addArrangedSubview(likeStackView)
        likeStackView.addArrangedSubview(likeImage)
        likeStackView.addArrangedSubview(likeTitle)
        
        lowerStackView.snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        
        lowerStackView.addArrangedSubview(dateStackView)
        dateStackView.addArrangedSubview(calendarImage)
        dateStackView.addArrangedSubview(timeTitle)
        
        lowerStackView.addArrangedSubview(expandButton)
    }
    
    @objc private func expandButtonTapped() {
        onButtonClick()
    }
}
