

We use three pointers:

- `low`: where the next `0` should go.
- `mid`: the element we are currently checking.
- `high`: where the next `2` should go.

## 0

If `nums[mid] == 0`

Swap `nums[low]` and `nums[mid]`. Then increase both `low` and `mid`.

## 1

If `nums[mid] == 1`

It is already in the correct middle section. Just increase `mid`.

## 2

If `nums[mid] == 2`

Swap `nums[mid]` and `nums[high]`. Then decrease `high`. Don't increase `mid`, because the swapped-in element hasn't been checked yet.

## Example walkthrough

Input: `[2,0,2,1,1,0]`

| Step | Action                            | Array           |
| ---- | --------------------------------- | --------------- |
| 1    | Swap 2 with the rightmost element | `[0,0,2,1,1,2]` |
| 2    | Move past the first 0             | `[0,0,2,1,1,2]` |
| 3    | Move past the second 0            | `[0,0,2,1,1,2]` |
| 4    | Swap 2 with 1                     | `[0,0,1,1,2,2]` |
| 5    | Move past both 1s                 | `[0,0,1,1,2,2]` |

Output: `[0,0,1,1,2,2]`

## Complexity

- Time: \\(O(n)\\) — each element is processed in constant time.
- Extra space: \\(O(1)\\) — only three pointers and one temporary variable.

Remember for interviews: When you see an array containing only `0`, `1`, and `2`, think of three pointers: `low`, `mid`, and `high`.
