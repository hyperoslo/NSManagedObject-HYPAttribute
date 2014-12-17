@import XCTest;

#import "NSManagedObject+HYPAttribute.h"
#import "User.h"

@interface Tests : XCTestCase

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation Tests

#pragma mark - Set up

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext) return _managedObjectContext;

    NSURL *modelURL = [[NSBundle bundleForClass:[self class]] URLForResource:@"Tests" withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    [psc addPersistentStoreWithType:NSInMemoryStoreType
                      configuration:nil
                                URL:nil
                            options:nil
                              error:nil];

    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _managedObjectContext.persistentStoreCoordinator = psc;

    return _managedObjectContext;
}

- (void)tearDown
{
    [self.managedObjectContext rollback];

    [super tearDown];
}

- (void)testAttributeClass
{
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                               inManagedObjectContext:self.managedObjectContext];

    XCTAssertEqualObjects([user hyp_attributeClassName:@"userID"], @"NSNumber");
    XCTAssertEqualObjects([user hyp_attributeClassName:@"name"], @"NSString");
}

- (void)testAttributeType
{
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                               inManagedObjectContext:self.managedObjectContext];

    XCTAssertEqual([user hyp_attributeType:@"userID"], NSInteger32AttributeType);
    XCTAssertEqual([user hyp_attributeType:@"name"], NSStringAttributeType);
}

- (void)testAttributeExists
{
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                               inManagedObjectContext:self.managedObjectContext];

    XCTAssertTrue([user hyp_attributeExists:@"userID"]);
    XCTAssertTrue([user hyp_attributeExists:@"name"]);
    XCTAssertFalse([user hyp_attributeExists:@"age"]);
    XCTAssertFalse([user hyp_attributeExists:@"email"]);
}

- (void)testAttributeNames
{
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                               inManagedObjectContext:self.managedObjectContext];

    XCTAssertEqual([[user hyp_attributeNames] count], 2);
    XCTAssertTrue([[user hyp_attributeNames] containsObject:@"userID"]);
    XCTAssertTrue([[user hyp_attributeNames] containsObject:@"name"]);
    XCTAssertFalse([[user hyp_attributeNames] containsObject:@"age"]);
    XCTAssertFalse([[user hyp_attributeNames] containsObject:@"email"]);
}

@end
