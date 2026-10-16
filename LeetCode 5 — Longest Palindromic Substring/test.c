
#include <string.h>

char* longestPalindrome(char* s) {
    int n = strlen(s);
    int start = 0, maxLen = 1;

    for (int i = 0; i < n; i++) {
        int left, right;

        // Odd-length palindrome: center is one character
        left = i;
        right = i;

        while (left >= 0 && right < n && s[left] == s[right]) {
            if (right - left + 1 > maxLen) {
                start = left;
                maxLen = right - left + 1;
            }
            left--;
            right++;
        }

        // Even-length palindrome: center is between characters
        left = i;
        right = i + 1;

        while (left >= 0 && right < n && s[left] == s[right]) {
            if (right - left + 1 > maxLen) {
                start = left;
                maxLen = right - left + 1;
            }
            left--;
            right++;
        }
    }

    s[start + maxLen] = '\0';
    return s + start;
}
