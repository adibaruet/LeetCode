# 13. Roman to Integer

## Problem Description
Given a Roman numeral string `s`, convert it into an integer.

Roman numerals use seven symbols: `I`, `V`, `X`, `L`, `C`, `D`, and `M`.

## Examples

**Example 1**
- Input: `s = "III"`
- Output: `3`

**Example 2**
- Input: `s = "LVIII"`
- Output: `58`

**Example 3**
- Input: `s = "MCMXCIV"`
- Output: `1994`

## Approach
1. Create a dictionary that maps each Roman symbol to its integer value.
2. Traverse the string from left to right.
3. If the current symbol has a smaller value than the next symbol, subtract its value.
4. Otherwise, add its value to the total.
5. Return the final total.

## Complexity Analysis
- **Time Complexity:** O(n), where `n` is the length of the string.
- **Space Complexity:** O(1), because the dictionary has a fixed number of symbols.

## Language
Python 3
