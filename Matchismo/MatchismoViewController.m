//
//  MatchismoViewController.m
//  Matchismo
//
//  Created by Bernardo Botelho on 10/15/13.
//  Copyright (c) 2013 Bernardo Botelho. All rights reserved.
//

#import "MatchismoViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "FlipResult.h"

@interface MatchismoViewController()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISwitch *gameSwitch;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (strong, nonatomic) UIImage *cardback;
@end

@implementation MatchismoViewController

- (UIImage *)cardback {
    if (!_cardback) {
        _cardback = [UIImage imageNamed:@"cardback.jpg"];
    }
    return _cardback;
}

- (IBAction)changeGameType:(id)sender {
    UISwitch *type = sender;
    
    if (type.on) {
        self.game.gameType = THREE_CARD_MATCH;
    } else {
        self.game.gameType = TWO_CARD_MATCH;
    }
}

- (IBAction)deal:(id)sender {
    _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init]];
    [[self scoreLabel] setText:@"Score: 0"];
    [[self messageLabel] setText:@""];
    [[self flipsLabel] setText:@"Flips: 0"];
    [self updateView];
}

- (CardMatchingGame *)game
{
    if (!_game)
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init]];
    
    return _game;
}

- (void) setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateView];
}

- (void)updateView
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        if (!card.faceUp) {
            [cardButton setBackgroundImage:self.cardback forState:UIControlStateNormal];
        } else {
            [cardButton setBackgroundImage:nil forState:UIControlStateNormal];
        }

        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    
    [self.gameSwitch setEnabled:!self.game.gameStarted];
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", [self flipCount]];
}

- (void) updateMessage:(FlipResult *)flipResult
{
    self.messageLabel.text = @"";
    if (flipResult.result == SimpleFlip) {
        self.messageLabel.text = [NSString stringWithFormat:@"Flipped up %@", flipResult.firstCard.contents];
    } else if (flipResult.result == Match) {
        self.messageLabel.text = [NSString stringWithFormat:@"Matched %@ and %@ for 4 points", flipResult.firstCard.contents, flipResult.secondCard.contents];
    } else if (flipResult.result == NoMatch) {
        self.messageLabel.text = [NSString stringWithFormat:@"%@ and %@ don't match! 2 points penalty!", flipResult.firstCard.contents, flipResult.secondCard.contents];
    }
}

- (IBAction)flipCard:(UIButton *)sender
{
    FlipResult *flipResult = [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateView];
    [self updateMessage:flipResult];
}

@end
