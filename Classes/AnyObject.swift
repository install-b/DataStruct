//
//  AnyObject.swift
//  DataStruct
//
//  Created by apple on 2020/7/24.
//

import Foundation


/// 判断是否为相同的内存地址的对象
func isSameObject<T: AnyObject>(_ left: T?, _ right: T?) -> Bool {
    guard let left = left, let right = right else { return false }
    return Unmanaged<T>.passUnretained(left).toOpaque() == Unmanaged<T>.passUnretained(right).toOpaque()
}
