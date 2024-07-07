//
//  CustomFlowLayout.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 07.07.24.
//

import UIKit

final class CustomFlowLayout: UICollectionViewFlowLayout {
    
    let sideInset: CGFloat = 16
    let spacing: CGFloat = 10
    
    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
        minimumLineSpacing = spacing
        sectionInset = UIEdgeInsets(top: 0, left: sideInset, bottom: 0, right: sideInset)
        itemSize = CGSize(width: collectionView!.bounds.width - 2 * sideInset, height: 570)
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        
        let collectionViewSize = collectionView.bounds.size
        let proposedContentOffsetCenterX = proposedContentOffset.x + collectionViewSize.width / 2
        
        guard let attributesForVisibleCells = layoutAttributesForElements(in: collectionView.bounds) else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        
        var candidateAttributes: UICollectionViewLayoutAttributes?
        
        for attributes in attributesForVisibleCells {
            if attributes.representedElementCategory != .cell {
                continue
            }
            
            if candidateAttributes == nil {
                candidateAttributes = attributes
                continue
            }
            
            if abs(attributes.center.x - proposedContentOffsetCenterX) < abs(candidateAttributes!.center.x - proposedContentOffsetCenterX) {
                candidateAttributes = attributes
            }
        }
        
        guard let attributes = candidateAttributes else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        
        let newOffsetX = attributes.center.x - collectionViewSize.width / 2
        return CGPoint(x: newOffsetX, y: proposedContentOffset.y)
    }
}
