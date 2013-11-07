//
//  NSKLabelNode.m
//  NodeSpriteKit
//
//  Created by Kevin Whinnery on 11/4/13.
//  Copyright (c) 2013 Kevin Whinnery. All rights reserved.
//

#import "NSKLabelNode.h"
#import "NSKUtils.h"
#import "NSKScene.h"

@implementation NSKLabelNode

// Update managed properties on a node, given the options specified
+(void)updateNode:(NSKLabelNode*)node withOptions:(NSDictionary*)options
{
    node.userInteractionEnabled = YES;
    
    node.name = [options objectForKey:@"uuid"];
    node.text = [options objectForKey:@"text"];
    node.fontSize = [[options objectForKey:@"fontSize"] floatValue];
    node.position = CGPointMake([[options objectForKey:@"x"] floatValue],
                                [[options objectForKey:@"y"] floatValue]);
    node.color = [NSKUtils colorForHex:[options valueForKey:@"color"]];
}

// Create a node with the given properties
+(id)create:(NSDictionary *)options
{
    NSKLabelNode *node = [[NSKLabelNode alloc] initWithFontNamed:[options objectForKey:@"fontFamily"]];
    [NSKLabelNode updateNode:node withOptions:options];
    return node;
}

// Update managed node properties
-(void)update:(NSDictionary *)options
{
    [NSKLabelNode updateNode:self withOptions:options];
}

-(void)addPhysics:(NSDictionary *)options
{
    // hard code a size for the physics body
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(320, 32)];
    self.physicsBody.dynamic = NO;
}

// Handle touch events
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];    
    NSKScene *scene = (NSKScene*) self.scene;
    [scene fireEvent:@{@"eventType":@"touch",
                       @"target":self.name,
                       @"data":@{@"x": [NSNumber numberWithFloat:positionInScene.x],
                                 @"y": [NSNumber numberWithFloat:positionInScene.y]}}];
}

@end
