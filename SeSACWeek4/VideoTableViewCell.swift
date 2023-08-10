//
//  VideoTableViewCell.swift
//  SeSACWeek4
//
//  Created by 이승현 on 2023/08/09.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.numberOfLines = 0
        contentLabel.font = .systemFont(ofSize: 13)
        contentLabel.numberOfLines = 2
        thumbnailImageView.contentMode = .scaleToFill
    }


}
