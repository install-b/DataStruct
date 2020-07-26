//
//  BST.swift
//  DataStruct
//
//  Created by Shangen Zhang on 2020/7/26.
//

import Foundation


public class BTNode<E> {
    var val: E
    var parent: Self?
    var left: Self?
    var right: Self?
    
    public init(val: E) {
        self.val = val
    }
}

/// AVL 树 节点
final class AVLNode<E>: BTNode<E> {
    // 高度
    var height = 0
    
    /// 平衡因子
    var factor: Int {
        (left?.height ?? 0) - (right?.height ?? 0)
    }
    
}

/// 颜色
typealias Color = Bool
let red: Color = true
let black: Color = false
/// 红黑树 节点
final class RBNode<E>: BTNode<E> {
    /// 颜色
    var color: Color = red
    
    /// 染色
    func render(color: Color) {
        self.color = color
    }
}

public protocol BST {
    associatedtype Element
    var root: BTNode<Element>? { get }
}
