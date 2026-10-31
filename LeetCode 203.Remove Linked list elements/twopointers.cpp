class Solution {
public:
    ListNode* removeElements(ListNode* head, int val) {

        // Remove matching nodes from the beginning
        while (head != NULL && head->val == val) {
            head = head->next;
        }

        ListNode* curr = head;

        // Check the remaining nodes
        while (curr != NULL && curr->next != NULL) {

            if (curr->next->val == val) {
                curr->next = curr->next->next;
            }
            else {
                curr = curr->next;
            }
        }

        return head;
    }
};
