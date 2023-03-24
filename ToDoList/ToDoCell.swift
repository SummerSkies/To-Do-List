//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Juliana Nielson on 3/23/23.
//

import UIKit

protocol ToDoCellDelegate: AnyObject {
    func checkmarkTapped(sender: ToDoCell)
}

class ToDoCell: UITableViewCell{

    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate: ToDoCellDelegate?
    
    func updateCheckImage() {
        if checkButton.isSelected {
            checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        } else {
            checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func checkButtonTapped(_ sender: Any) {
        delegate?.checkmarkTapped(sender: self)
        updateCheckImage()
    }
}
