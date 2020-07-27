//
//  AVLTree.swift
//  DataStruct
//
//  Created by apple on 2020/7/27.
//

import Foundation

/// AVL 树 节点
public final class AVLNode<E>: BTNode<E> {
    // 高度
    var height = 0
    
    /// 平衡因子
    var factor: Int {
        ((left as? AVLNode<E>)?.height ?? 0) - ((right as? AVLNode<E>)?.height ?? 0)
    }
    
}


/// AVL树 
public struct AVLTree<E>: BST {
    public typealias Element = E
    /// 跟节点
    private var _root: AVLNode<E>?
    public var root: BTNode<E>? {
        _root
    }
    
    /// 比较器
    public let cmp: BSTElementCompare<E>
    
    /// 构造方法
    public init(cmp: @escaping BSTElementCompare<E>) {
        self.cmp = cmp
    }
    
}

/// 元素具备可比性
extension AVLTree where E: Comparable {
    public init() {
        self.cmp = { (e1, e2) -> ComparisonResult in
            if e1 == e2 {
                return .orderedSame
            }
            return e1 < e2 ? .orderedAscending : .orderedDescending
        }
    }
}
