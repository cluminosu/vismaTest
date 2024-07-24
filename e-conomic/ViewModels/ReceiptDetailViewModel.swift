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
}
