=== victor_branch ===
{ not spoken_to_first:
    ~   speaker = "Shade"
    Victor, let's start with you.
~   spoken_to_first = true
}
Shade: Evelyn changed her will, leaving her estate to you instead of charity. That alone is suspicious, but add your shredded documents, and it's clear you had something to hide.
~   mood = "lean_smirk"
~   speaker = "Victor"
Evelyn's decision was her own. I simply helped her see the practicality of keeping her assets in the family. That's not a crime, is it?
~   speaker = "Shade"
But it wasn't practicality, was it? It was desperation. Your finanical transactions show deals that were dependant on you gaining control of Evelyn's art. She refused to sell out, so you made sure she wouldn't have a choice.
~   speaker = "Victor"
Detective, if you have proof of your accusations, I'd love to see it.
~   in_branch = "Victor"
-> branches

=== victor_push ===
~   speaker = "Shade"
Victor, the shredded documents in your office mentioned Marina and Evelyn's estate. You two planned this together, didn't you?
~   mood = "lean"
~   speaker = "Victor"
Planning? No. Discussing logistics? Perhaps. Evelyn's art was the cornerstone of our efforts to save the company. That required coordination.
~   speaker = "Shade"
Coordination to kill her? Marina provided the pills, you provided the motive, and together you silenced Evelyn when she refused to comply.
~   mood = "lean_smirk"
~   speaker = "Victor"
Bold accusation. Got proof?
{ check_pushes():
    -> turnabout
-   else:
    ~   in_branch = ""
    -> branches
}