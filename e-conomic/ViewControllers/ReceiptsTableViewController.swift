//
//  ReceiptsTableViewController.swift
//  e-conomic
//
//  Created by Claudiu Luminosu on 23.07.2024.
//

import UIKit

class ReceiptsTableViewController: UITableViewController {
    
    let dataManager: DataManager = DataManager.shared
    let viewModel = ReceiptsViewModel()

    override func viewWillAppear(_ animated: Bool) {
        self.loadData()
        super.viewWillAppear(animated)
    }
    private func loadData() {
        let coreDataEntities = self.dataManager.getAllReceipts()
        self.viewModel.setReceiptsFromCD(coreDataEntities: coreDataEntities)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.allReceipts?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "receiptCell", for: indexPath)
        let currentVM = self.viewModel.allReceipts![indexPath.row]
        cell.textLabel!.text = currentVM.info
        cell.detailTextLabel!.text = currentVM.stringDate
        cell.imageView?.image = currentVM.receiptImage
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentVM = self.viewModel.allReceipts![indexPath.row]
        self.showReceiptDetailView(viewModel: currentVM)
    }
    
    @IBAction func addNewReceipt() {
       
        let newReceiptVM = ReceiptDetailViewModel()
        newReceiptVM.isNewData = true
        newReceiptVM.dataManager = DataManager.shared
        self.showReceiptDetailView(viewModel: newReceiptVM)
    }
    
    private func showReceiptDetailView(viewModel: ReceiptDetailViewModel) {
        let newReceiptVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "receptsDetails") as! ReceiptsDetailsViewController
        newReceiptVC.viewModel = viewModel
        newReceiptVC.dataManager = self.dataManager
        self.navigationController?.pushViewController(newReceiptVC, animated: true)
    }

}

