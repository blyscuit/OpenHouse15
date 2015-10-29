//
//  ScheduleCell.swift
//  OpenHouseOneFive
//
//  Created by Romson Preechawit on 27/10/2558 BE.
//  Copyright © 2558 Thinc. All rights reserved.
//

import UIKit

class ScheduleCellScript: UITableViewCell{
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var barTop: UIImageView!
    @IBOutlet weak var barTopB: UIImageView!
    
    @IBOutlet weak var barBottom: UIImageView!
    
    @IBOutlet weak var dot: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib();
    }
    
    
}
