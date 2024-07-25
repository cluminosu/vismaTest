//
//  DataManager.swift
//  e-conomic
//
//  Created by Claudiu Luminosu on 23.07.2024.
//

import UIKit
import CoreData

class DataManager: NSObject {
    static let shared = DataManager()
    private override init() { }

    func getAllReceipts() -> [Receipt] {
        guard let managedContext = self.getContext() else { return [] }
        let request = NSFetchRequest<Receipt>(entityName: "Receipt")
        let allReceipts = (try? managedContext.fetch(request)) ?? []
        return allReceipts
    }
    
    func addNewReceipt(data: String, date: Date, amount: Int, currecy: String, imageLocation: String) {
        guard let managedContext = self.getContext() else { return }
        let newReceipt = Receipt(entity: Receipt.entity(), insertInto: managedContext)
        newReceipt.total = Int64(amount)
        newReceipt.info = data
        newReceipt.date = date
        newReceipt.currency = currecy
        newReceipt.imageURL = imageLocation
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    private func getContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate.persistentContainer.viewContext
    }
}
