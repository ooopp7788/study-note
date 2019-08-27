/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */
/**
 * @param {ListNode} head
 * @param {number} n
 * @return {ListNode}
 */
var removeNthFromEnd = function(head, n) {
  var ptr = head;
  var ptr2 = head;
  var prev = null;
  while(n) {
    ptr = ptr.next;
    n --;
  }
  while(ptr) {
    ptr = ptr.next;
    prev = ptr2;
    ptr2 = ptr2.next;
  }
  if (!prev) {
    return head.next;
  }
  prev.next = ptr2.next;
  return head;
};