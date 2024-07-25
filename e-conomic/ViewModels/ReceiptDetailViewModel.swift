//
//  ReceiptDetailViewModel.swift
//  e-conomic
//
//  Created by Claudiu Luminosu on 23.07.2024.
//

import UIKit

class ReceiptDetailViewModel: NSObject {
    var dataManager: DataManager?
    var isNewData: Bool = false
    var receiptImage: UIImage? = nil
    var amount: Int64? = nil
    var info: String? = nil
    var currency: String? = nil
    var date: Date? = nil
    var imageLocation: String? = nil
    var ident: String? = nil
    var stringDate: String {
        let formatter = DateFormatter()
        //2016-12-08 03:37:22 +0000
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        return formatter.string(from: self.date ?? Date.distantPast)
    }
    
    func saveReceipt() {
        self.dataManager?.saveReceipt(data: self.info ?? "",
                                      date: self.date!,
                                      amount: self.amount ?? 0,
                                      currecy: self.currency ?? "",
                                      imageLocation: self.imageLocation ?? "",
                                      ident: self.isNewData ? "\(UUID())" : self.ident!,
                                      isLatest: self.isNewData)
    }
    
    func getHistory() -> ReceiptsViewModel {
        let history = ReceiptsViewModel()
        history.setHistoryReceipts(forId: self.ident!)
        return history
    }
}
