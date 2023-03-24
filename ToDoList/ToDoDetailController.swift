//
//  ToDoDetailController.swift
//  ToDoList
//
//  Created by Juliana Nielson on 3/22/23.
//

import UIKit

class ToDoDetailController: UITableViewController {

    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    var toDo: ToDo?
    
    var datePickerHidden = true
    let dateLabelIndex = IndexPath(row: 0, section: 1)
    let datePickerIndex = IndexPath(row: 1, section: 1)
    let notesIndex = IndexPath(row: 0, section: 2)
    
    func updateCheckImage() {
        if checkButton.isSelected {
            checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        } else {
            checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let toDo = toDo {
            navigationItem.title = "To-Do"
            titleTextField.text = toDo.title
            checkButton.isSelected = toDo.isComplete
            dueDatePicker.date = toDo.dueDate
            notesTextView.text = toDo.notes
            updateCheckImage()
        } else {
            dueDatePicker.date = Date().addingTimeInterval(24 * 60 * 60)
        }
        
        updateDueDateLabel(date: dueDatePicker.date)
        updateSaveButtonState()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndex where datePickerHidden:
            return 0
        case notesIndex:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == dateLabelIndex {
            datePickerHidden.toggle()
            updateDueDateLabel(date: dueDatePicker.date)
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    func updateSaveButtonState() {
        let saveState = titleTextField.text?.isEmpty == false
        saveButton.isEnabled = saveState
    }
    
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let title = titleTextField.text!
        let isComplete = checkButton.isSelected
        let dueDate = dueDatePicker.date
        let notes = notesTextView.text
        
        if toDo != nil {
            toDo?.title = title
            toDo?.isComplete = isComplete
            toDo?.dueDate = dueDate
            toDo?.notes = notes
        } else {
            toDo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
        }
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    @IBAction func returnTapped(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func checkButtonToggle(_ sender: UIButton) {
        checkButton.isSelected.toggle()
        updateCheckImage()
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: sender.date)
    }
}
