//
//  PostsTableViewCell.swift
//  Posts_TestAssignment
//
//  Created by Maxym Bilyk on 01.09.2023.
//

import UIKit
import SnapKit

final class PostsTableViewCell: UITableViewCell {
    
    var wrapView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(hexString: Colors.title.name)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    var previewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(hexString: Colors.subTitle.name)
        label.textAlignment = .left
        label.numberOfLines = 2
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
        label.numberOfLines = 0
        return label
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
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupWrapView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ model: PostModel) {
        titleLabel.text = model.title
        previewLabel.text = model.previewText
        likeTitle.text = "\(model.likesCount)"
        let formattedDate = model.timeshamp.getFormattedDate(format: "dd MMM, yyyy")
        timeTitle.text = "\(formattedDate)"
    }
    
    private func setupWrapView() {
        wrapView.layer.cornerRadius = 8.0
        wrapView.layer.borderWidth = 0.50
        wrapView.layer.borderColor = UIColor(hexString: Colors.plainText.name).cgColor
        wrapView.clipsToBounds = false
    }
    
    private func setupLayout() {
        contentView.addSubview(wrapView)
        wrapView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8.0)
            make.leading.equalToSuperview().offset(8.0)
            make.trailing.equalToSuperview().inset(8.0)
            make.bottom.equalToSuperview().inset(8.0)
        }
        
        wrapView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16.0)
            make.leading.equalToSuperview().offset(16.0)
            make.trailing.equalToSuperview().inset(16.0)
        }
        
        wrapView.addSubview(previewLabel)
        previewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            make.leading.equalToSuperview().offset(16.0)
            make.trailing.equalToSuperview().inset(16.0)
        }
        
        wrapView.addSubview(likeImage)
        likeImage.snp.makeConstraints { make in
            make.top.equalTo(previewLabel.snp.bottom).offset(8.0)
            make.leading.equalToSuperview().offset(16.0)
            make.bottom.equalToSuperview().inset(16.0)
        }
        
        wrapView.addSubview(likeTitle)
        likeTitle.snp.makeConstraints { make in
            make.top.equalTo(previewLabel.snp.bottom).offset(8.0)
            make.leading.equalTo(likeImage.snp.trailing).offset(8.0)
            make.bottom.equalToSuperview().inset(16.0)
        }
        
        wrapView.addSubview(calendarImage)
        calendarImage.snp.makeConstraints { make in
            make.top.equalTo(previewLabel.snp.bottom).offset(8.0)
            make.leading.equalTo(likeTitle.snp.trailing).offset(16.0)
            make.bottom.equalToSuperview().inset(16.0)
        }
        
        wrapView.addSubview(timeTitle)
        timeTitle.snp.makeConstraints { make in
            make.top.equalTo(previewLabel.snp.bottom).offset(8.0)
            make.leading.equalTo(calendarImage.snp.trailing).offset(8.0)
            make.bottom.equalToSuperview().inset(16.0)
        }
    }
}
