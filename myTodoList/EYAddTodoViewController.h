//
//  EYAddTodoViewController.h
//  myTodoList
//
//  Created by bytedance on 2021/6/16.
//

#import <UIKit/UIKit.h>
#import "EYTodoItem.h"
@class EYAddTodoViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol EYAddTodoViewControllerDelegate <NSObject>

- (void)addTodo:(EYAddTodoViewController*)addTodoViewController withTodo:(EYTodoItem *)todoItem;

@end


@interface EYAddTodoViewController : UIViewController

@property (nonatomic, weak) id<EYAddTodoViewControllerDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
