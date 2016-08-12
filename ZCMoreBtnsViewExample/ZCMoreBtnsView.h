//
//  OraMoreBtnsView.h
//  test
//
//  Created by zhangcheng on 16/6/20.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, PopupDirection) {
    kPopupDirection_left = 0,
    kPopupDirection_right,
    kPopupDirection_up,
    kPopupDirection_down,
    kPopupDirection_leftdown,
    kPopupDirection_rightdown,
    kPopupDirection_leftup,
    kPopupDirection_rightup
};
@protocol ZCMoreBtnsViewDeleaget<NSObject>

- (void)ZC_tableviewCliekedIndexPath:(NSIndexPath *)indexpath;

@end
@interface ZCMoreBtnsView : UIView
@property(nonatomic, assign) BOOL animation;
@property(nonatomic, strong) NSIndexPath *seletedIndex;
@property(nonatomic, assign) CGFloat rowHeight;
@property(nonatomic, weak) id<ZCMoreBtnsViewDeleaget> delegate;
- (void)showMoreBtns;
/*
 *frame :整个view的大小，一般传mainScreen的bounds
 *titlesArray和images :列表每行的内容的数组和每行对应的图片的名称的数组
 *tableSize:表格的大小
 *point:锚点
 *animation:是否需要动画
 *popupDirection:动画其实位置（目前left,right,up,down,的动画没有缩放效果）
 *needScale:动画效果是否需要缩放
 */
- (instancetype)initWithFrame:(CGRect)frame
               AndTitlesArray:(NSArray *)titlesArray
                    AndImages:(NSArray *)images
             AndTableViewSize:(CGSize)tableSize
               AndAnchorPoint:(CGPoint)point
                 AndAniamtion:(BOOL)animation
            AndPopupDirection:(PopupDirection)popupDirection
                 AndNeedScale:(BOOL)needScale;
@end
