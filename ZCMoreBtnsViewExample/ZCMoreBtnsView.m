//
//  OraMoreBtnsView.m
//  test
//
//  Created by zhangcheng on 16/6/20.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCMoreBtnsView.h"
#import "ZCMoreBtnsTableViewCell.h"
CGFloat const defaultRowHeight=40;
@interface ZCMoreBtnsView ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableview;
@property(nonatomic, strong) NSArray *titlesArray;
@property(nonatomic, strong) NSArray *imagesArray;
@property(nonatomic, assign) CGRect tableFrame;
@property(nonatomic, assign) CGRect tableOriginalFrame;
@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) BOOL needScale;
@property(nonatomic, assign) CGPoint scaleAnchorPoint;
@end

@implementation ZCMoreBtnsView

- (UITableView *)tableview {
    if (!_tableview) {
       UITableView* tableview = [[UITableView alloc] initWithFrame:self.tableOriginalFrame style:UITableViewStylePlain];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.showsVerticalScrollIndicator = NO;
        tableview.bounces = NO;
        tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableview.backgroundColor = [UIColor colorWithRed:40.0 / 255.0 green:40.0 / 255.0 blue:40.0 / 255.0 alpha:1];
        if (_needScale && _animation) {
            tableview.layer.anchorPoint = _scaleAnchorPoint;
        }
        _tableview=tableview;
    }
    return _tableview;
}
- (instancetype)initWithFrame:(CGRect)frame
               AndTitlesArray:(NSArray *)titlesArray
                    AndImages:(NSArray *)images
             AndTableViewSize:(CGSize)tableSize
               AndAnchorPoint:(CGPoint)point
                 AndAniamtion:(BOOL)animation
            AndPopupDirection:(PopupDirection)popupDirection
                 AndNeedScale:(BOOL)needScale {
    self = [super initWithFrame:frame];
    if (self) {
        //
        UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        backgroundView.userInteractionEnabled = YES;
        backgroundView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
        backgroundView.alpha = 0.5;
        [self addSubview:backgroundView];
        //
        self.rowHeight = defaultRowHeight;
        self.animation = animation;
        self.width = tableSize.width;
        self.needScale = needScale;
        //
        self.titlesArray = titlesArray;
        self.imagesArray = images;
        //
        NSDictionary *dic = [self getRectWithPoint:point andSize:tableSize andPopupDirection:popupDirection];
        //
        self.tableFrame = [[dic objectForKey:@"futureRect"] CGRectValue];
        self.tableOriginalFrame = [[dic objectForKey:@"originalRect"] CGRectValue];
        [self addSubview:self.tableview];
        //
        UITapGestureRecognizer *tapGesture =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideTableview:)];
        tapGesture.numberOfTapsRequired = 1;
        [backgroundView addGestureRecognizer:tapGesture];
        //
    }
    return self;
}
- (NSDictionary *)getRectWithPoint:(CGPoint)point
                           andSize:(CGSize)size
                 andPopupDirection:(PopupDirection)PopupDirection {
    CGRect futureRect;
    CGRect originalRect;
    switch (PopupDirection) {
        case kPopupDirection_up:
            self.needScale = NO;
            originalRect = CGRectMake(point.x, point.y, size.width, 0);
            futureRect = CGRectMake(point.x, point.y, size.width, size.height);
            break;
        case kPopupDirection_down:
            self.needScale = NO;
            originalRect = CGRectMake(point.x, point.y, size.width, 0);
            futureRect = CGRectMake(point.x, point.y - size.height, size.width, size.height);
            break;
        case kPopupDirection_right:
            self.needScale = NO;
            originalRect = CGRectMake(point.x, point.y, 0, size.height);
            futureRect = CGRectMake(point.x - size.width, point.y, size.width, size.height);
            break;
        case kPopupDirection_left:
            self.needScale = NO;
            originalRect = CGRectMake(point.x, point.y, 0, size.height);
            futureRect = CGRectMake(point.x, point.y, size.width, size.height);
            break;
        case kPopupDirection_leftup:
            originalRect = CGRectMake(point.x, point.y, 0, 0);
            futureRect = CGRectMake(point.x, point.y, size.width, size.height);
            self.scaleAnchorPoint = CGPointMake(0, 0);
            break;
        case kPopupDirection_leftdown:
            originalRect = CGRectMake(point.x, point.y, 0, 0);
            futureRect = CGRectMake(point.x, point.y - size.height, size.width, size.height);
            self.scaleAnchorPoint = CGPointMake(0, 1);
            break;
        case kPopupDirection_rightup:
            originalRect = CGRectMake(point.x, point.y, 0, 0);
            futureRect = CGRectMake(point.x - size.width, point.y, size.width, size.height);
            self.scaleAnchorPoint = CGPointMake(1, 0);
            break;
        case kPopupDirection_rightdown:
            originalRect = CGRectMake(point.x, point.y, 0, 0);
            futureRect = CGRectMake(point.x - size.width, point.y - size.height, size.width, size.height);
            self.scaleAnchorPoint = CGPointMake(1, 1);
            break;
        default:
            break;
    }
    NSValue *originalRectValue = [NSValue valueWithCGRect:originalRect];
    NSValue *futureRectValue = [NSValue valueWithCGRect:futureRect];
    NSDictionary *dic = [NSDictionary
                         dictionaryWithObjectsAndKeys:originalRectValue, @"originalRect", futureRectValue, @"futureRect", nil];
    return dic;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titlesArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.titlesArray[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.rowHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 6;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 6)];
    header.backgroundColor = [UIColor colorWithRed:40.0 / 255.0 green:40.0 / 255.0 blue:40.0 / 255.0 alpha:1];
    //
    if (section != 0) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(14, 0, self.width - 28, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:68.0 / 255.0 green:68.0 / 255.0 blue:68.0 / 255.0 alpha:1];
        [header addSubview:line];
    }
    return header;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 6)];
    footer.backgroundColor = [UIColor colorWithRed:40.0 / 255.0 green:40.0 / 255.0 blue:40.0 / 255.0 alpha:1];
    return footer;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"TitlesCell";
    ZCMoreBtnsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ZCMoreBtnsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor clearColor];
    //
    if (self.titlesArray && self.titlesArray.count > indexPath.row) {
        cell.contentLabel.text = [self.titlesArray[indexPath.section] objectAtIndex:indexPath.row];
    } else {
        cell.contentLabel.text = @"";
    }
    if (self.imagesArray && self.imagesArray.count > indexPath.row) {
        cell.contentImg.image = [UIImage imageNamed:[self.imagesArray[indexPath.section] objectAtIndex:indexPath.row]];
    }
    //
    if (indexPath == self.seletedIndex) {
        cell.selectedImg.hidden = NO;
    } else {
        cell.selectedImg.hidden = YES;
    }
    return cell;
}
- (void)setSeletedIndex:(NSIndexPath *)seletedIndex {
    if (seletedIndex != _seletedIndex) {
        [self.tableview reloadData];
        _seletedIndex = seletedIndex;
    }
}
- (void)showMoreBtns {
    //
    if (self.animation) {
        if (self.needScale) {
            [self.tableview.layer removeAllAnimations];
            //缩放动画
            [self.tableview setFrame:self.tableFrame];
            //
            CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scaleAnimation.fromValue = [NSNumber numberWithFloat:0.0];
            scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
            scaleAnimation.duration = 0.4f;
            scaleAnimation.timingFunction =
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            
            [self.tableview.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        } else {
            [UIView animateWithDuration:0.25
                                  delay:0.3
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 [self.tableview setFrame:self.tableFrame];
                             }
                             completion:nil];
        }
        
    } else {
        [self.tableview setFrame:self.tableFrame];
    }
}
- (void)hideTableview:(UITapGestureRecognizer *)tapGesture {
    CGPoint point = [tapGesture locationInView:tapGesture.view];
    BOOL clickInTabelview = CGRectContainsPoint(self.tableFrame, point);
    if (!clickInTabelview) {
        if (!self.needScale && self.animation) {
            [self.tableview setFrame:self.tableOriginalFrame];
        }
        
        [self removeFromSuperview];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //
    if (!self.needScale && self.animation) {
        [self.tableview setFrame:self.tableOriginalFrame];
    }
    [self removeFromSuperview];
    //
    if (self.delegate && [self.delegate respondsToSelector:@selector(ZC_tableviewCliekedIndexPath:)]) {
        [self.delegate ZC_tableviewCliekedIndexPath:indexPath];
    }
}
@end
