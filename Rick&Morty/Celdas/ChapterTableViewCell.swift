//
//  ChapterTableViewCell.swift
//  Rick&Morty
//
//  Created by jose perez on 2019-02-26.
//  Copyright © 2019 jose perez. All rights reserved.
//

import UIKit

class ChapterTableViewCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbSeason: UILabel!
    @IBOutlet weak var lbAirDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbName.sizeToFit()
        lbSeason.sizeToFit()
        lbAirDate.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
