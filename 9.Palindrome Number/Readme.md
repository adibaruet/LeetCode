# 9. Palindrome Number

## Problem Description

Given an integer `x`, return `true` if `x` is a palindrome, and `false` otherwise.

A palindrome number reads the same forward and backward.

## Examples

**Example 1**
- Input: `x = 121`
- Output: `true`

**Example 2**
- Input: `x = -121`
- Output: `false`

**Example 3**
- Input: `x = 10`
- Output: `false`

## Approach

1. If the number is negative, return `false`.
2. Store the original number.
3. Extract the last digit using `x % 10`.
4. Build the reversed number using `rev = rev * 10 + digit`.
5. Remove the last digit using `x = x / 10`.
6. Repeat until `x` becomes zero.
7. Compare the reversed number with the original number. If they are equal, return `true`; otherwise, return `false`.

## Complexity Analysis

- **Time Complexity:** O(log₁₀ x), because each iteration processes one digit.
- **Space Complexity:** O(1), because only a constant number of variables are used.

## Language

C++
