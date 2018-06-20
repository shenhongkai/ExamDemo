//
//  Schedule.m
//  ExamDemo
//
//  Created by George She on 2018/6/8.
//  Copyright © 2018年 CMRead. All rights reserved.
//

#import "Schedule.h"

@interface Schedule()
@property (strong,nonatomic)NSMutableArray *listArray;
@property (strong,nonatomic)NSMutableArray *exisNodeIdtArray;///<已经注册成功的节点数组
@property (strong,nonatomic)NSMutableArray *upTaskIdtArray;///<挂起队列中存在的任务数组
@property (strong,nonatomic)TaskInfo *model;
@property (strong,nonatomic)NSMutableArray *upListArray;///<挂起在队列中的model数组

@end

@implementation Schedule
-(int)clean{
    
    self.listArray = [NSMutableArray new];
    self.exisNodeIdtArray = [NSMutableArray new];
    self.upListArray = [NSMutableArray new];
    
    
    if (self.listArray.count == 0)
    {
        return 1;
    }else{
        return 0;
    }
    
}

-(int)registerNode:(int)nodeId{
    
    NSInteger num = self.listArray.count;
    
    if (num > 0)
    {
        for (int i = 0;  i< num; i++)
        {
            TaskInfo *tempInfo  = self.listArray[i];
            NSLog(@" sss = %d",tempInfo.nodeId);
            [self.exisNodeIdtArray addObject:[NSNumber numberWithInt:tempInfo.nodeId]];
        }
    }
    
    if (nodeId < 0){
        return 4;
    }
    else if ([self.exisNodeIdtArray containsObject:[NSNumber numberWithInt:nodeId]])
    {
        return 5;
    }
    else
    {
        TaskInfo *info  = [[TaskInfo alloc]init];
        info.nodeId = nodeId;
        
        [self.listArray addObject:info];
        [self.exisNodeIdtArray addObject:[NSNumber numberWithInt:info.nodeId]];
        return 3;
    }
}

-(int)unregisterNode:(int)nodeId{
    
    
    
    if (nodeId < 0)
    {
        return 4;
    }
    else if (![self.exisNodeIdtArray containsObject:[NSNumber numberWithInt:nodeId]])
    {
        return 7;
    }
    else if (self.listArray.count)
    {
        //   NSNumber *num = [NSNumber numberWithInt:nodeId];
        
        TaskInfo *deInfo = [[TaskInfo alloc]init];

        for (int i = 0; i < self.listArray.count; i ++) {
            TaskInfo *info  = self.listArray[i];
            if (info.nodeId == nodeId)
            {
                if (info.taskId)
                {
                    TaskInfo *tempInfo = [[TaskInfo alloc]init];
                    tempInfo.taskId = info.taskId;
                    [self.upListArray addObject:tempInfo];
                }
                
                deInfo = info;
            }
            
        }
        
        [self.listArray removeObject:deInfo];
        return 6;
    }
    else
    {
        return 0;
    }
}

-(int)addTask:(int)taskId withConsumption:(int)consumption{
    
    NSMutableArray *upexisNodeIdtArray = [NSMutableArray new];
    
    if (self.upListArray.count)
    {
        for (int i = 0; i < self.upListArray.count; i ++) {
            TaskInfo *tempInfo = self.upListArray[i];
            [upexisNodeIdtArray addObject:[NSNumber numberWithInt:tempInfo.taskId]];
        }
    }
    
    if (taskId <= 0) {
        return 9;
    }
    else if ([upexisNodeIdtArray containsObject:[NSNumber numberWithInt:taskId]])
    {
        return 10;
    }
    else
    {
        TaskInfo *tempInfo = [[TaskInfo alloc]init];
        tempInfo.taskId = taskId;
        tempInfo.consumption = consumption;
        [self.upListArray addObject:tempInfo];
        return 8;
    }
}

-(int)deleteTask:(int)taskId{
    
    NSMutableArray *listTaskIdArr = [NSMutableArray new];
    NSMutableArray *upTaskIdArr = [NSMutableArray new];
    
    for (int i = 0; i < self.listArray.count; i++)
    {
        TaskInfo *tempInfo = self.listArray[i];
        [listTaskIdArr addObject: [NSNumber numberWithInt:tempInfo.taskId]];
    }
    
    for (int i = 0; i < self.upListArray.count ; i ++) {
        TaskInfo *tempInfo = self.upListArray[i];
        
        [upTaskIdArr addObject:[NSNumber numberWithInt:tempInfo.taskId]];
    }

    NSNumber *num = [NSNumber numberWithInt:taskId];
    
    if (taskId <= 0)
    {
        return 9;
    }
    else if (![listTaskIdArr containsObject:num] && ![upTaskIdArr containsObject:num])
    {
        return 12;
    }
    else
    {
        if ([listTaskIdArr containsObject:num])
        {
            for (int i = 0; i < self.listArray.count; i++)
            {
                TaskInfo *tempInfo = self.listArray[i];
                if (tempInfo.taskId == taskId)
                {
                    tempInfo.taskId = 0;
                }
            }
        }
        
        if ([upTaskIdArr containsObject:num])
        {
            for (int i = 0; i < self.upListArray.count; i++)
            {
                TaskInfo *tempInfo = self.upListArray[i];
                if (tempInfo.taskId == taskId)
                {
                    tempInfo.taskId = 0;
                }
            }
        }
        
        return 11;
    }

    
}

-(int)scheduleTask:(int)threshold{
    
    if (self.upListArray.count)
    {

    }
    
    return 0;
}

-(int)queryTaskStatus:(NSMutableArray<TaskInfo *> *)tasks{
    return 0;
}
@end
