//
//  ReceiptsViewModel.swift
//  e-conomic
//
//  Created by Claudiu Luminosu on 23.07.2024.
//

import UIKit

class ReceiptsViewModel: NSObject {
    var allReceipts: [ReceiptDetailViewModel]? = nil
    
    func setReceiptsFromCD(coreDataEntities: [Receipt]) {
        var newReceipts :[ReceiptDetailViewModel] = []
        for receipt in coreDataEntities {
            let newReceipt = ReceiptDetailViewModel()
            newReceipt.info = receipt.info
            newReceipt.date = receipt.date
            newReceipt.amount = Int(receipt.total)
            newReceipt.currency = receipt.currency
            newReceipt.receiptImage = self.loadImage(imagePath: receipt.imageURL ?? "")
            newReceipts.append(newReceipt)
        }
        self.allReceipts = newReceipts
    }
    
    private func loadImage(imagePath: String) -> UIImage? {
        var documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        documentsPath.append("/\(imagePath)")
        
        guard let image = UIImage(contentsOfFile: documentsPath) else {
            return nil
        }
        return image
    }
    
    private func fileExists(at path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }
}
