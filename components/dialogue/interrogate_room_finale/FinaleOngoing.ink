INCLUDE FinaleVictor.ink
INCLUDE FinaleMarina.ink
INCLUDE FinaleLucas.ink


VAR speaker = "Narrator"
VAR spoken_to_first = false
VAR mood = "normal"
VAR in_branch = ""

=== function check_pushes ===
    ~ return victor_push && marina_push && lucas_push

=== branches ===
~   speaker = "Shade"
*   {in_branch == ""} [Victor's financial motives]
    -> victor_branch
*   {victor_branch && in_branch == "Victor"} [Push further]
    -> victor_push
*   {in_branch == ""} [Marina's suspicious behavior]
    -> marina_branch
*   {marina_branch && in_branch == "Marina"} [Push further]
    -> marina_push
*   {in_branch == ""} [Lucas' alibi]
    -> lucas_branch
*   {lucas_branch && in_branch == "Lucas"} [Push further]
    -> lucas_push
*   {in_branch != ""}[Ask someone else]
    -> push_reset

=== push_reset ===
~   in_branch = ""
-> branches

=== turnabout ===
~   speaker = "Shade"
Here's how it happened. Marina drugged Evelyn under the guise of helping her relax. Victor showed up later to confront Evelyn about the will and the company's future. When she still refused, he killed her--using Marina's setup to stage the scene, and later they cleaned it out.
~   speaker = "Marina"
I didn't want her dead! Victor said it was just to scare her into compliance. He lied to me!
~   speaker = "Victor"
You were complicit, Marina. Don't play the victim now.
~   speaker = "Shade"
Enough! Victor Blake, you're under arrest for the murder of Evelyn Blake. Marina Thorne, you're under arrest as an accomplice.
-> end

=== end ===
~   speaker = "Shade"
You'll regret this, Shade.
~   speaker = "Shade"
I didn't mean for this to happen!
~   speaker = "Shade"
Evelyn deserved better. Thank you for finding the truth.
-> END