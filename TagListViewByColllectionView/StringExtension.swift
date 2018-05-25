//
//  StringExtension.swift
//  TagListViewByColllectionView
//
//  Created by EthanLin on 2018/5/25.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import Foundation
import UIKit

extension String{
    func rect(withFont font: UIFont, size: CGSize) -> CGRect {
        return (self as NSString).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [kCTFontAttributeName as NSAttributedStringKey: font], context: nil)
    }
    /// 根据固定的size和font计算文字的height
    func height(withFont font: UIFont, size: CGSize) -> CGFloat {
        return self.rect(withFont: font, size: size).height
    }
    /// 根据固定的size和font计算文字的width
    func width(withFont font: UIFont, size: CGSize) -> CGFloat {
        return self.rect(withFont: font, size: size).width
    }
}
