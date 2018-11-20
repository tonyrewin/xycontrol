//
//  XYView.h
//  XY Control


#import <UIKit/UIKit.h>

@protocol XYViewDelegate <NSObject>
- (void)controlValueChanged:(CGPoint)point;
@end


@interface XYView : UIView

@property (nonatomic, weak) id<XYViewDelegate> delegate;
@property (nonatomic, assign) CGPoint xyPosition;

@end
