//
//  SkipLinkList.swift
//  DataStruct
//
//  Created by apple on 2020/7/24.
//

import Foundation


extension SkipLinkList {
    /// 跳表节点
    final class Node<E>: LinkListNode {
        typealias Element = E
        var val: E
        var nexts: [Node<E>]
        var next: Node<E>? { nexts.first }
        
        init(val: E, nexts: [Node<E>] = []) {
            self.val = val
            self.nexts = nexts
        }
    }
}

/// 跳表
public struct SkipLinkList<T: Comparable> {
    
}
