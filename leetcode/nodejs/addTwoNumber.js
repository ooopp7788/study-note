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
  let restNode = l2;
  while(l1) {
    const val = l1.val + restNode.val;
    restNode.val = val % 10;
    const addToNext = (val - restNode.val) / 10;
    console.log(restNode.next, addToNext)
    if (restNode.next) {
      restNode = restNode.next;
      restNode.val = restNode.val + addToNext;
    } else {
      restNode.next = l1.next;
      return l2;
    }
    l1 = l1.next;
  }
  return l2;
};

console.log(addTwoNumbers(createLinkList([9,8]),createLinkList([1])));