//
//  TableViewExtension.swift
//  ONSports
//
//  Created by trandat on 01/09/2021.
//

import Foundation
import UIKit

extension UITableView {
    func scrollToTop() {
        self.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
}

extension UICollectionView {
    func scrollToTop() {
        self.setContentOffset(.zero, animated: false)
    }
}
