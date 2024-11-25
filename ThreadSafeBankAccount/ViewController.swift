//
//  ViewController.swift
//  ThreadSafeBankAccount
//
//  Created by Admin on 25/11/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        performConcurrentTransactions()
    }

    func performConcurrentTransactions() {
        let account = BankAccount(initialBalance: 1000)
        let group = DispatchGroup()
        
        //concurrent deposit and withdrawal
        DispatchQueue.global().async(group: group) {
            account.deposit(amount: 200)
        }
        
        DispatchQueue.global().async(group: group) {
            account.withdraw(amount: 150)
        }
        
        DispatchQueue.global().async(group: group) {
            account.withdraw(amount: 300)
        }
        
        DispatchQueue.global().async(group: group) {
            account.deposit(amount: 400)
        }
        
        group.notify(queue: DispatchQueue.main) {
            print("All transactions completed. final balance = \(account.checkBalance())")
        }
    }

}

