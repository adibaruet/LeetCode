
double findMedianSortedArrays(int* nums1, int nums1Size,
                              int* nums2, int nums2Size) {
    int a[2000];
    int i = 0, j = 0, k = 0;
    int total = nums1Size + nums2Size;

    while (i < nums1Size && j < nums2Size) {
        if (nums1[i] < nums2[j]) {
            a[k++] = nums1[i++];
        } else {
            a[k++] = nums2[j++];
        }
    }

    while (i < nums1Size) {
        a[k++] = nums1[i++];
    }

    while (j < nums2Size) {
        a[k++] = nums2[j++];
    }

    if (total % 2 == 1) {
        return a[total / 2];
    } else {
        return (a[total / 2 - 1] + a[total / 2]) / 2.0;
    }
}
