Isomorphic means the characters in two strings follow the same pattern.
For each position `i`:

1. Check whether `s[i]` and `t[i]` were last seen at the same position.
2. If not, return `false`.
3. Otherwise, update both arrays with `i + 1`.

We use `i + 1` because `0` means the character hasn't appeared before.

Example: `s = "egg"`, `t = "add"`

| i | s[i] | t[i] | Result                               |
| - | ---- | ---- | ------------------------------------ |
| 0 | e    | a    | Both new — continue                  |
| 1 | g    | d    | Both new — continue                  |
| 2 | g    | d    | Both last seen at index 1 — continue |

Returns `true`.

Complexity

- Time: \\(O(n)\\)
- Space: \\(O(1)\\), since the arrays have a fixed size of 256.

Key idea: Each character must have a consistent mapping in both directions.
