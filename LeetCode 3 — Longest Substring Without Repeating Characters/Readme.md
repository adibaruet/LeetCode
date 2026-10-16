
We use three important variables:

- `left`: starting index of the current substring.
- `i`: ending index of the current substring.
- `maxLen`: length of the longest valid substring found so far.

The `last[256]` array stores the last position where each character appeared. Initially, every position is `-1`, meaning the character has not appeared yet.

### Example: `"abcabcbb"`

Follow the sliding window

Previous

Step 3 of 5

Next

## a

0

## b

1

## c

2

## a

3

## b

4

## c

5

## b

6

## b

7

Current substring: abc

Current maximum length: 3

Green cells show the current valid window in this simplified walkthrough.

When a repeated character appears inside the current window, move `left` to the position immediately after its previous occurrence.

For example, in `"abcabcbb"`, when the second `a` appears at index `3`, the previous `a` was at index `0`. So:

`left = 0 + 1 = 1`

The window becomes `"bca"`, whose length is still `3`.

The length of the current window is:

\\[ \text{length} = i - left + 1 \\]

We update `maxLen` whenever this length is greater than the previous maximum.

## Complexity

- Time: \\(O(n)\\) — each character is processed once.
- Extra space: \\(O(1)\\) — the array has a fixed size of 256.

Important C detail: `unsigned char c = s[i];` ensures that the character is used as a valid non-negative array index.
