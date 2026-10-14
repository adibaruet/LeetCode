The main difference between Same Tree (LeetCode 100) and Symmetric Tree (LeetCode 101) is what you compare.

## 1. Same Tree vs Symmetric Tree

[K Sum Paths | Practice | GeeksforGeeks](https://images.openai.com/static-rsc-4/EcQjdUiSbhh38BlN0JLoKKWa54p8AXZn4Q19NzEfgo45dL8sZkQNFBdAzYtHU2Ju5JkflPWJdh1-aDb2Yd9jXRnq5MkK0N8-IMlYN58U7bG09dJy4MaJmyQU90H9tROLdRmoqlRjpoAL3xy0-wO77fK9Z3GnA8U_PU2LTEF-JzI?purpose=inline)

Same Tree

Two separate trees must have the same structure and same values at every corresponding position.

[101. Symmetric Tree - DEV Community](https://images.openai.com/static-rsc-4/cpQWh8nhPU6HLnfRo3OimIxw_oQs8A9r7NXNc-QnMCJ6QFCFLOC-zsfjgleFh8sEIBXRIAMnARHNr-Wvtm40_j0nxcCE1GNPA1MfMxxmA4NLInp9LiRYcx7SPQj1DnuxWR5XPkcqtLv1nuOLRLd9XEk27IdlFy9bxN40-8ADIaQ?purpose=inline)

Symmetric Tree

One tree's left side must be the mirror image of its right side.

## 2. The key difference in code

Same Tree:

```
return isSameTree(p->left, q->left) &&
       isSameTree(p->right, q->right);
```

Compare left with left and right with right.

Symmetric Tree:

```
return isMirror(left->left, right->right) &&
       isMirror(left->right, right->left);
```

Compare left with right and right with left.

## 3. Remember this trick

- Same Tree: Same direction — left ↔ left, right ↔ right.
- Symmetric Tree: Opposite direction — left ↔ right, right ↔ left.

That's the whole trick! The recursive base cases (checking `NULL` and node values) are very similar in both problems.
