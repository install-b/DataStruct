//
//  BST.swift
//  DataStruct
//
//  Created by Shangen Zhang on 2020/7/26.
//

import Foundation

/// 比较
public typealias BSTElementCompare<E> = (_ e1: E, _ e2: E) -> ComparisonResult

/// 二叉搜索树
public protocol BST {
    /// 泛型类型
    associatedtype Element
    /// 根节点
    var root: BTNode<Element>? { get }
    /// 比较器
    var cmp: BSTElementCompare<Element> { get }
}


/// insert
extension BST {
    /// 插入
    
}

/// 遍历操作
public extension BST {
    
}
