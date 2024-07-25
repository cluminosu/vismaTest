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
        var request = NSFetchRequest<Receipt>(entityName: "Receipt")
        request = Receipt.fetchRequest()
        request.predicate = NSPredicate(format:"isLatest == %@", NSNumber(true))
        let allReceipts = (try? managedContext.fetch(request)) ?? []
        return allReceipts
    }
    
    func getReceiptsFor(id: String) -> [Receipt] {
        guard let managedContext = self.getContext() else { return [] }
        var request = NSFetchRequest<Receipt>(entityName: "Receipt")
        request = Receipt.fetchRequest()
        request.predicate = NSPredicate(format:"identifier == %@",NSString(string: "\(id)"))
        let allReceipts = (try? managedContext.fetch(request)) ?? []
        return allReceipts
    }
    
    func saveReceipt(data: String, date: Date, amount: Int64, currecy: String, imageLocation: String, ident: String, isLatest: Bool) {
        guard let managedContext = self.getContext() else { return }
        let newReceipt = Receipt(entity: Receipt.entity(), insertInto: managedContext)
        newReceipt.identifier = ident
        newReceipt.total = Int64(amount)
        newReceipt.info = data
        newReceipt.date = date
        newReceipt.currency = currecy
        newReceipt.imageURL = imageLocation
        newReceipt.isLatest = isLatest
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
