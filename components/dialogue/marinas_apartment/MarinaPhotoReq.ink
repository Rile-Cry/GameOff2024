LIST actors = Marina
VAR speaker = "Shade"
VAR mood = "defensive_2"
VAR photo_scene = "Case/Photos/Marina’s Apartment.tres"
VAR marina_photo = false

~   mood = "defensive_2"
~   speaker = "Marina"
You again? I thought I made it clear we were done! #shake
~   speaker = "Shade"
* [Leverage Previous Respect]
    Last time, I respected your boundaries. But a photo could genuinely help me tie things together.
    This isn’t personal, it’s part of my job.
    ~   mood = "defensive_1"
    ~   speaker = "Marina"
    ~   marina_photo = true
    F... fine. But don’t make me regret trusting you. #exclaim#Photo#{photo_scene}
    -> END
* [Appeal to Shared Goals]
    We both want to move forward. A photo might speed things up and close this case faster, so you and Victor can move on.
    ~   mood = "soft_guarded"
    ~   speaker = "Marina"
    ~   marina_photo = true
    Hm... If it gets you out of my hair faster, fine. One photo.#Photo#{photo_scene}
    -> END
* [Subtle Pressure]
    Your apartment might hold the missing detail that changes everything. If you’re innocent, there’s no harm in helping me out.
    ~   mood = "sassy"
    ~   speaker = "Marina"
    ...... #exclaim
    ~   mood = "sigh"
    ~   marina_photo = true
    Take your photo. But if I find out you’re wasting my time, there’ll be hell to pay.#Photo#{photo_scene}
    -> END