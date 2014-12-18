#import "NSManagedObject+HYPAttribute.h"

@implementation NSManagedObject (HYPAttribute)

- (NSString *)hyp_attributeClassName:(NSString *)attribute
{
    NSAttributeDescription *attributeDescription = [self attributeDescriptionForAttribute:attribute];
    if (!attributeDescription) return nil;

    return [attributeDescription attributeValueClassName];
}

- (NSAttributeType)hyp_attributeType:(NSString *)attribute
{
    NSAttributeDescription *attributeDescription = [self attributeDescriptionForAttribute:attribute];
    if (!attributeDescription) return NSUndefinedAttributeType;

    return attributeDescription.attributeType;
}

- (BOOL)hyp_attributeExists:(NSString *)attribute
{
    return ([self.entity propertiesByName][attribute] != nil);
}

- (NSArray *)hyp_attributeNames
{
    return [[self.entity propertiesByName] allKeys];
}

#pragma mark - Private methods

- (NSAttributeDescription *)attributeDescriptionForAttribute:(NSString *)attribute
{
    id propertyDescription = [self.entity propertiesByName][attribute];
    if (![propertyDescription isKindOfClass:[NSAttributeDescription class]]) return nil;

    NSAttributeDescription *attributeDescription = (NSAttributeDescription *)propertyDescription;

    return attributeDescription;
}

@end
