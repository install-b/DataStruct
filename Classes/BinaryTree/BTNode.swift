//
//  BTNode.swift
//  DataStruct
//
//  Created by apple on 2020/7/27.
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
