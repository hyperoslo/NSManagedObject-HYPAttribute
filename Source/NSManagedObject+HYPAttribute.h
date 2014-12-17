@import CoreData;

@interface NSManagedObject (HYPAttribute)

- (NSString *)hyp_attributeClassName:(NSString *)attribute;
- (NSAttributeType)hyp_attributeType:(NSString *)attribute;
- (BOOL)hyp_attributeExists:(NSString *)attribute;

@end
