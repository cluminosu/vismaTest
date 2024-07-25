//
//  HistoryTableViewController.swift
//  e-conomic
//
//  Created by Claudiu Luminosu on 25.07.2024.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    public var viewModel: ReceiptsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.allReceipts?.count ?? 0
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "histCell", for: indexPath)

        let cellViewModel = self.viewModel!.allReceipts![indexPath.row]
        cell.textLabel!.text = "info:\(cellViewModel.info ?? "")\namount: \(cellViewModel.amount ?? 0)\n currency: \(cellViewModel.currency ?? "")\ndate: \(cellViewModel.stringDate)"
        return cell
    }

}
