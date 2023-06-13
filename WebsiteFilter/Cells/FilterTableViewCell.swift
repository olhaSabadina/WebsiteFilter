//
//  FilterTableViewCell.swift
//  WebsiteFilter
//
//  Created by Olya Sabadina on 2023-06-09.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    
    static let cellId = "cellId"
    
    let filterLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        filterLabel.frame = CGRect(x: 20, y: 5, width: contentView.frame.width - 40, height: contentView.frame.height - 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(filterLabel)
    }
}
