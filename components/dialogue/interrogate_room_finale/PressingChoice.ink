VAR is_pressing = false
* [Press]
    ~ is_pressing = true
    [Perhaps there is something I can use to press further]
    -> END
* [Dont Press]
    ~ is_pressing = false
    I see, In guess I'll get back to you later.
    -> END