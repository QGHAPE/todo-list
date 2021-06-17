//
//  AddTodoViewController.h
//  myTodoList
//
//  Created by bytedance on 2021/6/16.
//

#import <UIKit/UIKit.h>
#import "TodoItem.h"
@class AddTodoViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol AddTodoViewControllerDelegate <NSObject>

- (void)addTodo:(AddTodoViewController*)addTodoViewController withTodo:(TodoItem *)todoItem;

@end


@interface AddTodoViewController : UIViewController

@property (nonatomic, weak) id<AddTodoViewControllerDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
