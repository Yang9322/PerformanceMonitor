//
//  PerformanceMonitor.m
//  SuperApp
//
//  Created by tanhao on 15/11/12.
//  Copyright © 2015年 Tencent. All rights reserved.
//

#import "PerformanceMonitor.h"
#import "BSBacktraceLogger.h"
@interface PerformanceMonitor ()
{
    int timeoutCount;
    CFRunLoopObserverRef observer;
    
    @public
    dispatch_semaphore_t semaphore;
    CFRunLoopActivity activity;
    long start;
    long finish;
}
@end

@implementation PerformanceMonitor

+ (instancetype)sharedInstance
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    PerformanceMonitor *moniotr = (__bridge PerformanceMonitor*)info;
    
    moniotr->activity = activity;
    moniotr->finish  = 0;
    
    if (activity == kCFRunLoopBeforeSources) {
        
        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
        moniotr->start = (long)(interval * 1000);
    }
    if (activity == kCFRunLoopAfterWaiting) {
        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
        moniotr->finish = (long)(interval * 1000);
        
        dispatch_semaphore_t semaphore = moniotr->semaphore;
        dispatch_semaphore_signal(semaphore);
    }

}

- (void)stop
{
    if (!observer)
        return;
    
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    CFRelease(observer);
    observer = NULL;
}

- (void)start
{
    if (observer)
        return;
    
    // 信号
    semaphore = dispatch_semaphore_create(0);
    
    // 注册RunLoop状态观察
    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
    observer = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                       kCFRunLoopAllActivities,
                                       YES,
                                       0,
                                       &runLoopObserverCallBack,
                                       &context);
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    
    // 在子线程监控时长
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (YES)
        {
            long st = dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW,DISPATCH_TIME_FOREVER));
            if (st != 0)
            {
                if (!observer)
                {
                    timeoutCount = 0;
                    semaphore = 0;
                    activity = 0;
                    return;
                }
                
                if ( activity==kCFRunLoopAfterWaiting)
                {
//                    if (++timeoutCount < 5){
//
//                        continue;
//                    }
//                    PLCrashReporterConfig *config = [[PLCrashReporterConfig alloc] initWithSignalHandlerType:PLCrashReporterSignalHandlerTypeBSD
//                                                                                       symbolicationStrategy:PLCrashReporterSymbolicationStrategyAll];
//                    PLCrashReporter *crashReporter = [[PLCrashReporter alloc] initWithConfiguration:config];
//                    
//                    NSData *data = [crashReporter generateLiveReport];
//                    PLCrashReport *reporter = [[PLCrashReport alloc] initWithData:data error:NULL];
//                    NSString *report = [PLCrashReportTextFormatter stringValueForCrashReport:reporter
//                                                                              withTextFormat:PLCrashReportTextFormatiOS];
                    if (finish -start >200) {
                        NSLog(@"begin---%ld---end",finish -start);

                    }
//                    NSLog(@"begin---%@---end",[BSBacktraceLogger bs_backtraceOfAllThread]);
 
//                    NSLog(@"------------\n%@\n------------", report);
                }
            }
            timeoutCount = 0;
        }
    });
}

@end
