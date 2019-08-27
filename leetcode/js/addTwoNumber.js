function ListNode(val) {
  this.val = val;
  this.next = null;
}
function createLinkList(list){
  const val = list.shift();
  if (val === undefined) return null;
  let node = new ListNode(val)
  node.next = createLinkList(list);
  return node;
}

// createLinkList([1,2,3])

/**
 * @param {ListNode} l1
 * @param {ListNode} l2
 * @return {ListNode}
 */
var addTwoNumbers = function(l1, l2) {
  let r = new ListNode(0);
  let ptr = r;
  while(l1 || l2) {
    const val1 = l1 ? l1.val : 0;
    const val2 = l2 ? l2.val : 0;

    const val = val1 + val2 + ptr.val;
    ptr.val = val % 10;
    const addToNext = Math.floor(val / 10);
    ptr.next = new ListNode(addToNext);

    if (l1) l1 = l1.next;
    if (l2) l2 = l2.next;
    ptr = ptr.next;
  }
  return r;
};

console.log(addTwoNumbers(createLinkList([9,8]),createLinkList([1])));