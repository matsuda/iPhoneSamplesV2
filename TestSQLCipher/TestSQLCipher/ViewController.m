//
//  ViewController.m
//  TestSQLCipher
//
//  Created by Kosuke Matsuda on 2014/04/22.
//  Copyright (c) 2014年 matsuda. All rights reserved.
//

#import "ViewController.h"
#import <FMDatabase.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self testDB];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testDB
{
    /**
     PRAGMA key = 'test';
     */
    [self.database setKey:@"test"];
//    [self.database setKey:@"hoge"];
    BOOL canAccess = [self challengeQuery];
    if (canAccess) {
        [self migrateUser];
        [self findUsers];
        [self.database rekey:@"hoge"];
    }
    [self findUsers];
}

- (BOOL)challengeQuery
{
    NSString *sql = @"PRAGMA integrity_check;";
    FMResultSet *rs = [self.database executeQuery:sql];
    if (!rs) {
        int resultCode = [self.database lastErrorCode];
        NSLog(@"resultCode >>>> %d", resultCode);
        if (resultCode == SQLITE_NOTADB) {
            [self.database close];
            NSLog(@"database >>>>>>>> %@", self.database);
            NSString *path = self.database.databasePath;
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
            }
            self.database = [FMDatabase databaseWithPath:path];
            NSLog(@"database >>>>>>>> %@", self.database);
            [self.database open];
            [self.database setKey:@"hoge"];
            [self migrateUser];
        }
    }
    return rs != nil;
}

- (void)migrateUser
{
    [self createUsers];
    [self insertUser];
}

- (void)findUsers
{
    NSString *sql = @"SELECT * FROM users";
    FMResultSet *rs = [self.database executeQuery:sql];
    while ([rs next]) {
        NSDictionary *dict = [rs resultDictionary];
        NSLog(@"%@", dict);
        // NSString *name = [rs stringForColumn:@"name"];
        // NSLog(@"name >>> %@", name);
    }
}

- (void)insertUser
{
    NSString *sql = @"INSERT INTO users (name) values('test')";
    [self.database executeUpdate:sql];
}

- (void)createUsers
{
    NSString *sql = @"CREATE TABLE IF NOT EXISTS users ("
    "primaryKey INTEGER PRIMARY KEY AUTOINCREMENT,"
    "name TEXT"
    ")";
    BOOL isResult = [self.database executeUpdate:sql];
    NSLog(@"isResult >>>>> %d", isResult);
    if (!isResult) {
        int resultCode = [self.database lastErrorCode];
        NSLog(@"%d", resultCode);
        if (resultCode == SQLITE_NOTADB) {
            NSLog(@"mmmmmmmmmmmmm");
        }
    }
}

@end
