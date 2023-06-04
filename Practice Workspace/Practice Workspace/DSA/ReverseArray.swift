//
//  ReverseArray.swift
//  Practice Workspace
//
//  Created by Powerplay on 02/06/23.
//


import Foundation

class ReverseArray {
    var array = [1,2,3,4,5]
    
    ///  O(n)
    ///  O(1)
    private func reverse1() -> [Any] {
        return array.reversed()
    }
    
    ///   O(n)
    ///   O(n)
    private func reverse2() -> [Any] {
        return Array(array.reversed())
    }
    
    ///   O(n)
    ///   O(1)
    private func reverse3() -> [Any] {
        var count = array.count
        
        for i in 0...count/2 {
            swap(&array[i], &array[count-1])
        }
        return array
    }
}
