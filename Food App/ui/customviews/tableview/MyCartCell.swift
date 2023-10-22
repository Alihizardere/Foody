//
//  MyCartCell.swift
//  Food App
//
//  Created by alihizardere on 13.10.2023.
//

import UIKit

protocol cellProtocol{
    func deleteFood(indexPath:IndexPath)
}

class MyCartCell: UITableViewCell {
    
    @IBOutlet weak var labelFoodName: UILabel!
    @IBOutlet weak var labelFoodImage: UIImageView!
    @IBOutlet weak var labelFoodPrice: UILabel!
    @IBOutlet weak var labelFoodNumber: UILabel!
    @IBOutlet weak var labelFoodTotalPrice: UILabel!
    
    var cellProtocol:cellProtocol?
    var indexPath:IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func buttonDeleteFood(_ sender: Any) {
        cellProtocol?.deleteFood(indexPath: indexPath!)
    }
}
