//
//  BankAccount.swift
//  ThreadSafeBankAccount
//
//  Created by Admin on 25/11/24.
//

import UIKit


class BankAccount {
    
    private var balance : Int //shared resource
    private let queue = DispatchQueue(label:"com.bankaccount.queue")//serial queue for synchronization
    
    init(initialBalance :Int) {
        self.balance = initialBalance
    }
    
    //deposit method
    func deposit(amount:Int)  {
        queue.sync { //synchronize access
            self.balance += amount
            print("Deposited \(amount). New balance: \(self.balance)")
        }
    }
    
    //withdraw method
    func withdraw(amount:Int) {
        queue.sync {
            if self.balance >= amount {
                self.balance -= amount
                print("withdrew amount \(amount) remaining balance = \(self.balance)")
                
            }else {
                print("insufficient funds to withdraw")
            }
        }
    }
    
    //check balance
    func checkBalance() -> Int {
        queue.sync {
            return balance
        }
    }
 }
