module type S =
  Scheduler_intf.S

module Make (Ws_hub_base : Ws_hub.BASE) : S
