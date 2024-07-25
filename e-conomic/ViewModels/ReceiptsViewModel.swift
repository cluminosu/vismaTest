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
        self.allReceipts = ReceiptsViewModel.processCDReceipts(cdReceipts: coreDataEntities)
    }
    
    func setHistoryReceipts(forId ident: String) {
        let hist = DataManager.shared.getReceiptsFor(id: ident)
        self.allReceipts = ReceiptsViewModel.processCDReceipts(cdReceipts: hist)
    }
    
    class func processCDReceipts(cdReceipts: [Receipt]) -> [ReceiptDetailViewModel] {
        var receipts: [ReceiptDetailViewModel] = []
        for receipt in cdReceipts {
            let newReceipt = ReceiptDetailViewModel()
            newReceipt.info = receipt.info
            newReceipt.date = receipt.date
            newReceipt.amount = Int64(receipt.total)
            newReceipt.currency = receipt.currency
            newReceipt.ident = receipt.identifier
            newReceipt.dataManager = DataManager.shared
            newReceipt.receiptImage = ReceiptsViewModel.loadImage(imagePath: receipt.imageURL ?? "")
            receipts.append(newReceipt)
        }
        return receipts
    }
    
    private class func loadImage(imagePath: String) -> UIImage? {
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
