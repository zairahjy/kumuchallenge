//
//  Number+.swift
//  KumuChallenge
//
//  Created by Zairah Ylagan on 2/11/22.
//

import Foundation

extension Decimal {
    
    /// Format to string
    func formatted(with currency: String? = nil) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        formatter.numberStyle = .decimal
        
        if let currency = currency {
            formatter.currencyCode = currency
            formatter.numberStyle = .currency
        }
        
        return formatter.string(for: self) ?? "?"
    }
}
