//
//  MMUXYView.h
//  XY Control
//
//  Created by Gary Newby on 11/03/2013.
//
//

#import <UIKit/UIKit.h>

@protocol XYViewDelegate <NSObject>
- (void)controlValueChanged:(CGPoint)point name:(NSString *)name;
@end


@interface XYView : UIView

@property (nonatomic, weak) id<XYViewDelegate> delegate;
@property (nonatomic, assign) CGPoint xyPosition;
@property(nonatomic, strong) NSString *name;

@end
