//
//  ReceiptsDetailsViewController.swift
//  e-conomic
//
//  Created by Claudiu Luminosu on 23.07.2024.
//

import UIKit

class ReceiptsDetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public var viewModel: ReceiptDetailViewModel?
    public var dataManager: DataManager?
    
    private var date: Date?
    
    @IBOutlet weak var dateTextField: UITextField?
    @IBOutlet weak var infoTextField: UITextField?
    @IBOutlet weak var amountTextField: UITextField?
    @IBOutlet weak var currencyTextField: UITextField?
    @IBOutlet weak var receiptImageView: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.infoTextField?.delegate = self
        self.amountTextField?.delegate = self
        self.currencyTextField?.delegate = self
        
        
        // populate data in case it's not a new receipt
        let formatter = DateFormatter()
        //2016-12-08 03:37:22 +0000
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        if self.viewModel?.isNewData == true {
          
            let now = Date()
            let dateString = formatter.string(from:now)
            self.date = now
            self.dateTextField?.text = dateString
        } else {
            self.infoTextField?.text = self.viewModel?.info
            self.amountTextField?.text = "\(self.viewModel?.amount ?? 0)"
            self.currencyTextField?.text = self.viewModel?.currency
            let dateString = formatter.string(from:self.viewModel?.date ?? Date())
            self.dateTextField?.text = dateString
            self.date = (self.viewModel?.date)!
        }
    }
    
    @IBAction func addNewImage() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        
        self.receiptImageView?.image = image
    }
    
    @IBAction func saveReceipt() {
        guard self.receiptImageView?.image != nil &&
        self.infoTextField?.text != nil &&
        self.amountTextField?.text != nil else { return }
        
        let imageURL = self.saveImageToDocuments()
        let amountInteger = Int(self.amountTextField!.text!)
        self.dataManager?.addNewReceipt(data: self.infoTextField?.text ?? "",
                                        date: self.date!,
                                        amount: amountInteger ?? 0,
                                        currecy: self.currencyTextField?.text ?? "",
                                        imageLocation: imageURL)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func saveImageToDocuments() -> String {
        guard let image = self.receiptImageView?.image else { return "" }
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        if let filePath = paths.first?.appendingPathComponent("\(UUID())") {
            // Save image.
            do {
               try image.pngData()?.write(to: filePath, options: .atomic)
            } catch let error as NSError {
                print("Could not save image. \(error), \(error.userInfo)")
            }
            return filePath.absoluteString
        }

        return ""
    }
}

extension ReceiptsDetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         textField.resignFirstResponder()
        return true
    }
}
