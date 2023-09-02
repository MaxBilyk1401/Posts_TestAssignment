//
//  FilterView.swift
//  Posts_TestAssignment
//
//  Created by Maxym Bilyk on 02.09.2023.
//

import UIKit
import SnapKit

class FilterView: UIView {
    
    var onLikeFilterButtonTapped: ((Bool) -> Void)?
    var onDateFilterButtonTapped: ((Bool) -> Void)?
    
    var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8.0
        stack.distribution = .fillProportionally
        return stack
    }()
    
    var likeButton: UIButton =  {
        let button = UIButton()
        button.setTitle("Filter by likes", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 4.0
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var dateButton: UIButton =  {
        let button = UIButton()
        button.setTitle("Filter by dates", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 4.0
        button.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(16.0)
            make.trailing.equalToSuperview().inset(16.0)
            make.bottom.equalToSuperview()
        }
        
        mainStackView.addArrangedSubview(likeButton)
        mainStackView.addArrangedSubview(dateButton)
    }
    
    
    @objc private func likeButtonTapped() {
        onLikeFilterButtonTapped?(false)
    }
    
    @objc private func dateButtonTapped() {
        onDateFilterButtonTapped?(false)
    }
}
