//
//  AP.swift
//  Practice Workspace
//
//  Created by Powerplay on 06/06/23.
//

import Foundation

class Solution {
    func canMakeArithmeticProgression(_ arr: [Int]) -> Bool {
        let a = arr.sorted()
        for i in a.indices.dropFirst(2) {
            if a[i] - a[i - 1] != a[1] - a[0] {
                return false
            }
        }
        return true
    }
}
