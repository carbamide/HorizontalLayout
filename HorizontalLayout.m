//
//  HorizontalLayout.m
//  Collection
//
//  Created by Josh Barrow on 10/21/12.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <math.h>
#import "HorizontalLayout.h"

@implementation HorizontalLayout

#define kItemHeight 80
#define kItemWidth 80
#define kMinimumLineSpacing 10

-(id)init
{
    if (self = [super init]) {
        [self setItemSize:CGSizeMake(kItemHeight, kItemWidth)];
        [self setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [self setSectionInset:UIEdgeInsetsMake(8, 8, 8, 8)];
        [self setMinimumLineSpacing:kMinimumLineSpacing];
    }
    
    return self;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [super layoutAttributesForElementsInRect:rect];
}

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    float offsetAdjustment = MAXFLOAT;
    float horizontalCenter = (float)proposedContentOffset.x + (self.collectionView.bounds.size.width / 2.0);
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0f, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    NSArray *superLayoutAttributes = [super layoutAttributesForElementsInRect:targetRect];
    
    for (UICollectionViewLayoutAttributes *layoutAttributes in superLayoutAttributes) {
        float itemHorizontalCenter = layoutAttributes.center.x;
        
        if (abs(itemHorizontalCenter - horizontalCenter) < abs(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

@end


