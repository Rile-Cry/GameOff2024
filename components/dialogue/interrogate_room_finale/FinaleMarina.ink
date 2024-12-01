=== marina_branch ===
{ not spoken_to_first:
    ~   speaker = "Shade"
    Marina, let's start with you.
~   spoken_to_first = true
}
~   speaker = "Shade"
Marina, Evelyn's phone was found in your locked compartment. Care to explain why?
~   mood = "sassy"
~   speaker = "Marina"
She left it at my place during one of our meetings. I meant to return it, but then... well, you know what happened.
~   speaker = "Shade"
Strange, considering Evelyn texted Lucas the night of her death. Are you saying she somehow managed that without her phone?
~   mood = "defensive_1"
~   speaker = "Marina"
Are you seriously suggesting I had something to do with her death? Victor and I were trying to protect her legacy, unlike some people.
~   in_branch = "Marina"
-> branches

=== marina_push ===
~   speaker = "Shade"
Marina, the receipts for wine and sleeping pills point directly to you. You drugged Evelyn to make her vulnerable. Care to deny it?
~   mood = "guarded"
~   speaker = "Marina"
You're twisting everything! I gave her pills because she couldn't sleep. The wine was for a celebration we'd planned. I didn't kill her!
~   speaker = "Shade"
But you knew what Victor planned. You helped him set her up and clean the scene afterwards.
~   mood = "defensive_2"
~   speaker = "Marina"
Stop putting words in my mouth.
{ check_pushes():
    -> turnabout
-   else:
    ~   in_branch = ""
    -> branches
}