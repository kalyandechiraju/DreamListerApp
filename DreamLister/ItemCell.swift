//
//  ItemCell.swift
//  DreamLister
//
//  Created by Kalyan Dechiraju on 28/03/17.
//  Copyright © 2017 Codelight Studios. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemDetail: UILabel!

    func configureCell(item: Item) {
        self.itemTitle.text = item.title
        self.itemPrice.text = "$\(item.price)"
        self.itemDetail.text = item.details
    }

}
