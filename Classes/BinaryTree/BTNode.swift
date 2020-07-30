//
//  BTNode.swift
//  DataStruct
//
//  Created by apple on 2020/7/27.
//

import Foundation

/// 二叉树节点 Abstract Class
public class BTNode<E>: CustomDebugStringConvertible {
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
    
    public var debugDescription: String {
        "val=: \(val), \nleft: \(left)\nright:\(right)"
    }

    open func getBSTReplaceNode() -> (node: BTNode<E>, isLeft: Bool)? {
        guard var node = left, let rightNode = node.right else {
            if var node = right {
               
                while node.left != nil {
                    node = node.left!
                }
                return (node: node, isLeft: !isSameObject(right, node))
            }
            return nil
        }
        node = rightNode
        while node.right != nil {
            node = node.right!
        }
        return (node: node, isLeft: false)
    }
  
    var isLeafNode: Bool {
        left == nil && right == nil
    }
    
}
