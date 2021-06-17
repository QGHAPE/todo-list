//
//  ViewController.m
//  myTodoList
//
//  Created by bytedance on 2021/6/16.
//

#import "ViewController.h"
#import "AddTodoViewController.h"
#import "TodoItem.h"

@interface ViewController () <AddTodoViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *arr;//存放待完成事项
@property (nonatomic, strong) NSMutableArray *finArr;//存放已完成事项

@end

@implementation ViewController

- (NSMutableArray *)arr
{
    if(!_arr)
    {
        _arr = [[NSMutableArray alloc] init];
    }
    return _arr;
}

- (NSMutableArray *)finArr
{
    if(!_finArr)
    {
        _finArr = [[NSMutableArray alloc] init];
    }
    return _finArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
    
    
    
}

//实现代理方法
-(void)addTodo:(AddTodoViewController *)addTodoViewController withTodo:(TodoItem *)todoItem
{
    //数据添加到可变数组中
    [self.arr addObject:todoItem];
    //刷新
    [self.tableView reloadData];
}

//设置代理
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AddTodoViewController *add = segue.destinationViewController;
    add.delegate = self;
}

#pragma mark----实现tableView代理方法
//分两个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0) return self.arr.count;
    else return self.finArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"todo_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    if(indexPath.section == 0)
    {
        TodoItem *item = self.arr[indexPath.row];
        cell.textLabel.text = item.todo;
    }
    else
    {
        TodoItem *finItem = self.finArr[indexPath.row];
        cell.textLabel.text = finItem.todo;
    }
    
    return  cell;
}

//组头
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
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
    if(indexPath.section == 0){
        //先删模型
        [self.arr removeObjectAtIndex:indexPath.row];
        //再删cell
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationFade)];
    }
    else
    {
        //先删模型
        [self.finArr removeObjectAtIndex:indexPath.row];
        //再删cell
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationFade)];
    }
    
}

#pragma mark----实现todo完成
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    //获取点击的事项
    if(indexPath.section==1) return;
    //弹出对话框
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:@"是否完成事项" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *finishAction = [UIAlertAction actionWithTitle:@"完成事项" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取完成的模型
        TodoItem *item = self.arr[indexPath.row];
        //先删模型
        [self.arr removeObjectAtIndex:indexPath.row];
        //再删cell
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationFade)];
        //已完成添加事项
        [self.finArr addObject:item];
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
