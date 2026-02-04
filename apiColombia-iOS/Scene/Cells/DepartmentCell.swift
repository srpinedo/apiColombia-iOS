//
//  UniversalCell.swift
//  apiColombia-iOS
//
//  Created by Joan on 3/02/26.
//

import UIKit

class UniversalCell: UITableViewCell {
    static let identifier = "UniversalCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(name: String, description: String?) {
        var config = defaultContentConfiguration()
        config.text = name
        config.secondaryText = description
        config.textProperties.font = .systemFont(ofSize: 16, weight: .medium)
        config.secondaryTextProperties.color = .secondaryLabel
        config.secondaryTextProperties.numberOfLines = 1
        contentConfiguration = config
    }
}
