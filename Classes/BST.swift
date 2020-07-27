//
//  BST.swift
//  DataStruct
//
//  Created by Shangen Zhang on 2020/7/26.
//

import Foundation


/// 二叉树节点
public class BTNode<E> {
    /// 元素值
    var val: E
    /// 父节点
    var parent: BTNode<E>?
    /// 左子树
    var left: BTNode<E>?
    /// 右子树
    var right: BTNode<E>?
    
    /// 构造器方法
    public init(val: E, parent: BTNode<E>? = nil, left: BTNode<E>? = nil, right: BTNode<E>? = nil) {
        self.val = val
        self.parent = parent
        self.left = left
        self.right = right
    }
}

/// AVL 树 节点
final class AVLNode<E>: BTNode<E> {
    // 高度
    var height = 0
    
    /// 平衡因子
    var factor: Int {
        ((left as? AVLNode<E>)?.height ?? 0) - ((right as? AVLNode<E>)?.height ?? 0)
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


/// 二叉搜索树
public protocol BST {
    /// 泛型类型
    associatedtype Element
    /// 根节点
    var root: BTNode<Element>? { get }
}


extension BST {
    /// 插入
}

/// 遍历操作
public extension BST {
    
}
