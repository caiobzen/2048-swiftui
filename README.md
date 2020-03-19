# 2048 Game

###### The 2048 game remake using [SwiftUI](https://developer.apple.com/xcode/swiftui) and [Combine](https://developer.apple.com/documentation/combine)

You can find an article explaining the implementation here: [Medium](https://medium.com/@caiobzen/2048-swiftui-dda67949beb)

<a href="https://codeclimate.com/github/caiobzen/2048-swiftui/maintainability"><img src="https://api.codeclimate.com/v1/badges/a56aa52cda5f80c18494/maintainability" /></a>

--- 

### 🕹️ The Game

2048 is a single-player sliding block puzzle game designed by Italian web developer [Gabriele Cirulli](https://gabrielecirulli.com). The game's objective is to slide numbered tiles on a grid to combine them to create a tile with the number 2048. However, one can continue to play the game after reaching the goal, creating tiles with larger numbers.


### 🚂 Motivation

After watching a series of [The Coding Train](https://www.youtube.com/watch?v=JSn-DJU8qf0) on how to implement the 2048 game in JavaScript with P5, I got the inspiration to do the same with SwiftUI and Combine. So some of the logics behind matrices manipulation I borrowed from Mr. [Daniel Shiffman](https://twitter.com/shiffman) *(Keep inspiring people with your videos <3)*.

### 💻 Requirements
- iOS 13+
- XCode 11

### 🤓 How to run
Since this project has zero dependencies on external frameworks, all you need is:
- `⌘ + R` *(and that's it)*

### ☑️ Todo
1. Stats (number of moves, time played, etc)
2. Work on the animations (there's no animation for shifting tiles along the board for example)
3. ~A way to UNDO an action.~ (thanks [@t0a0](https://github.com/t0a0) for doing that!)
