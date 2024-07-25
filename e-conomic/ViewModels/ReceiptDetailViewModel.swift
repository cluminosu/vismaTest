//
//  ReceiptDetailViewModel.swift
//  e-conomic
//
//  Created by Claudiu Luminosu on 23.07.2024.
//

import UIKit

class ReceiptDetailViewModel: NSObject {
    var isNewData: Bool = false
    var receiptImage: UIImage? = nil
    var amount: Int? = nil
    var info: String? = nil
    var currency: String? = nil
    var date: Date? = nil
    var stringDate: String {
        let formatter = DateFormatter()
        //2016-12-08 03:37:22 +0000
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        return formatter.string(from: self.date ?? Date.distantPast)
    }
    
}
