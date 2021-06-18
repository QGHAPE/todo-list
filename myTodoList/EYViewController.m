//
//  EYViewController.m
//  myTodoList
//
//  Created by bytedance on 2021/6/16.
//

#import "EYViewController.h"
#import "EYAddTodoViewController.h"
#import "EYTodoItem.h"

@interface EYViewController () <EYAddTodoViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *todoArray;//存放待完成事项
@property (nonatomic, strong) NSMutableArray *completedArray;//存放已完成事项

@end

@implementation EYViewController

- (NSMutableArray *)todoArray
{
    if (!_todoArray)
    {
        _todoArray = [[NSMutableArray alloc] init];
    }
    return _todoArray;
}

- (NSMutableArray *)completedArray
{
    if (!_completedArray)
    {
        _completedArray = [[NSMutableArray alloc] init];
    }
    return _completedArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
    
    
    
}

//设置代理
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    EYAddTodoViewController *add = segue.destinationViewController;
    add.delegate = self;
}

//实现代理方法
-(void)addTodo:(EYAddTodoViewController *)addTodoViewController withTodo:(EYTodoItem *)todoItem
{
    //数据添加到可变数组中
    [self.todoArray addObject:todoItem];
    //刷新
    [self.tableView reloadData];
}

#pragma mark----实现tableView代理方法

//分两个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return self.todoArray.count;
    }
    else
    {
        return self.completedArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"todo_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    if (indexPath.section == 0)
    {
        EYTodoItem *item = self.todoArray[indexPath.row];
        cell.textLabel.text = item.todo;
    }
    else
    {
        EYTodoItem *finItem = self.completedArray[indexPath.row];
        cell.textLabel.text = finItem.todo;
    }
    
    return  cell;
}

//组头
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"未完成事项";
    }
    else
    {
        return @"已完成事项";
    }
}

//编辑cell
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        //先删模型
        [self.todoArray removeObjectAtIndex:indexPath.row];
        //再删cell
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationFade)];
    }
    else
    {
        //先删模型
        [self.completedArray removeObjectAtIndex:indexPath.row];
        //再删cell
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationFade)];
    }
    
}

#pragma mark----实现todo完成

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    //获取点击的事项
    if (indexPath.section==1) return;
    //弹出对话框
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:@"是否完成事项" message:nil          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *finishAction = [UIAlertAction actionWithTitle:@"完成事项" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取完成的模型
        EYTodoItem *item = self.todoArray[indexPath.row];
        //先删模型
        [self.todoArray removeObjectAtIndex:indexPath.row];
        //再删cell
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationFade)];
        //已完成添加事项
        [self.completedArray addObject:item];
        //刷新
        [self.tableView reloadData];
    }];
       
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [actionSheetController addAction:cancelAction];
    [actionSheetController addAction:finishAction];
    
    [self presentViewController:actionSheetController animated:YES completion:nil];
    
}




@end
