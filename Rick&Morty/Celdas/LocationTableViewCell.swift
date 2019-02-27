//
//  LocationTableViewCell.swift
//  Rick&Morty
//
//  Created by jose perez on 2019-02-26.
//  Copyright © 2019 jose perez. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var lbNombre: UILabel!
    @IBOutlet weak var lbTipo: UILabel!
    @IBOutlet weak var lbDimension: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbNombre.sizeToFit()
        lbTipo.sizeToFit()
        lbDimension.sizeToFit()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
