//
//  ResultTableViewCell.swift
//  Workday Coding
//
//  Created by Miguel Angeles on 6/9/23.
//

import UIKit

class ContentTableViewCell : UITableViewCell {
    static let identifier = "ContentTableViewCell"
    
    let image : UIImage = {
        var image = UIImage()
        
        return image
    }()
    
    let titleLabel : UILabel = {
        var label = UILabel()
        
        return label
    }()
    
    let descriptionLabel : UILabel = {
        var label = UILabel()
        
        return label
    }()
    
    let dateLabel : UILabel = {
        var label = UILabel()
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
       
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell(_ image: String, _ title: String, _ description: String){
        titleLabel.text = title
        descriptionLabel.text = description
    
    }
    
    private func configureConstraints(){
        
    }
    
}
