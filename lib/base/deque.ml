type 'a node = {
  mutable prev : 'a node ;
  mutable next : 'a node ;
  v : 'a ;
}
type 'a t = {
  front_sentinel : 'a node ;
  back_sentinel : 'a node ;
}

let make () =
  let rec front_sentinel =
    { prev = front_sentinel ;
      next = back_sentinel ;
      v = Obj.magic () ;
    }
  and back_sentinel =
    { prev = front_sentinel ;
      next = back_sentinel ;
      v = Obj.magic () ;
    }
  in
  {front_sentinel ; back_sentinel}

let [@inline] is_empty t =
  t.front_sentinel.next == t.back_sentinel

let insert node1 node2 v =
  let node = {prev = node1 ; next = node2 ; v} in
  node1.next <- node ;
  node2.prev <- node

let remove node =
  let prev = node.prev in
  let next = node.next in
  prev.next <- next ;
  next.prev <- prev

let push_front t v =
  insert t.front_sentinel t.front_sentinel.next v

let pop_front t =
  let front = t.front_sentinel.next in
  if front == t.back_sentinel then (
    None
  ) else (
    remove front ;
    Some front.v
  )

let push_back t v =
  insert t.back_sentinel.prev t.back_sentinel v

let pop_back t =
  let back = t.back_sentinel.prev in
  if back == t.front_sentinel then (
    None
  ) else (
    remove back ;
    Some back.v
  )
