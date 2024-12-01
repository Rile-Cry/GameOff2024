=== lucas_branch ===
{ not spoken_to_first:
    ~   speaker = "Shade"
    Shade: Lucas, let's start with you.
~   spoken_to_first = true
}
Lucas, your alibi was shaky at best. Witnesses saw you near the studio after midnight.
~   mood = "defensive_2"
~   speaker = "Lucas"
I didn't kill her! I went back because I was worried about her. I saw the light on and thought something was wrong, but when I got there, she was already--
~   speaker = "Shade"
Dead? Or drugged and unconscious, waiting for Victor to finish the job?
~   mood = "panic"
~   speaker = "Lucas"
I don't know! I didn't stay long. I couldn't handle it!
~   in_branch = "Lucas"
-> branches

=== lucas_push ===
~   speaker = "Shade"
Lucas, your reaction tells me you're hiding something. What aren't you saying?
~   mood = "tweaking"
~   speaker = "Lucas"
I loved her! But I knew something was wrong. Victor kept pushing her, and Marina was always in her ear. I should've done more to protect her!
~   speaker = "Shade"
But you didn't. You were too afraid of what they'd do, weren't you?
{ check_pushes():
    -> turnabout
-   else:
    ~   in_branch = ""
    -> branches
}