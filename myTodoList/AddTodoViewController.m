//
//  AddTodoViewController.m
//  myTodoList
//
//  Created by bytedance on 2021/6/16.
//

#import "AddTodoViewController.h"

@interface AddTodoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *todoContent;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation AddTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.todoContent.placeholder = @"请输入代办事项";
    self.addButton.enabled = 0;
    //监听添加代办事项栏是否改变
    [self.todoContent addTarget:self action:@selector(textChange) forControlEvents:(UIControlEventEditingChanged)];
    //监听完成按钮是否点击
    [self.addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)textChange
{
    self.addButton.enabled = self.todoContent.text.length > 0;
}

-(void)addClick
{
    //判断代理是否响应
    if([self.delegate respondsToSelector:@selector(addTodo:withTodo:)])
    {
        TodoItem *todoItem = [[TodoItem alloc] init];
        todoItem.todo = self.todoContent.text;
        [self.delegate addTodo:self withTodo:todoItem];
    }
    
    //返回上一个控制器
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
