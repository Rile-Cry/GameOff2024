INCLUDE FinaleVictor.ink
INCLUDE FinaleMarina.ink
INCLUDE FinaleLucas.ink

LIST actors = Lucas, Marina, Victor
VAR speaker = "Narrator"
VAR spoken_to_first = false
VAR mood = "normal"
VAR in_branch = ""

VAR culprit = ""
VAR accomplice = ""

=== function check_pushes ===
    ~ return victor_push && marina_push && lucas_push

=== function add_suspect(name) ===
    {
        -   culprit == "":
            ~   culprit = name
        -   accomplice == "":
            ~   accomplice = name
    }

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
Marina, the evidence is clear. You drugged Evelyn under the guise of helping her sleep. But ou weren't just there as a bystander. You were involved when she died.
~   mood = "tweaking"
~   speaker = "Marina"
I didn't want this! It wasn't supposed to go this far! I just... I just wanted her to sign over the estate... but Victor--he--
~   speaker = "Victor"
Wait Victor? You both were there?
~   speaker = "Shade"
It was Victor...He said it would be fine. That we'd just scare her into signing it, but when she refused... he killed her. He killed her, and I stayed. I--I helped him clean up.
-> denial

=== denial ===
~   mood = "blame_marina"
~   speaker = "Victor"
She's lying! She was the one who wanted to push Evelyn, to force her into signing. I never wanted any of this! She helped clean up, she helped cover everything up.
~   speaker = "Shade"
You were both there. You couldn't control her, so you killed her. Marina might have helped clean up, but the murder was yours wasn't it, Victor?
~   mood = "defensive_2"
~   speaker = "Victor"
I never meant for it to happen. She wouldn't listen, she wouldn't cooperate! You don't understand the pressure I was under. I had no choice! No choice!
-> timeline_choice

=== timeline_choice ===
~   speaker = "Shade"
Now let me tell you all how the crime went.
{
    - culprit == "":
        (Who is the main culprit?)
    - accomplice == "":
        (Who is the accomplice?)
    - else:
        -> timeline
}
*   [Victor]
    ~   add_suspect("Victor")
    -> timeline_choice
*   [Marina]
    ~   add_suspect("Marina")
    -> timeline_choice
*   [Lucas]
    ~   add_suspect("Lucas")
    -> timeline_choice
*   {culprit != ""}[That's all]
    -> timeline

=== timeline ===
~   speaker = "Shade"
{accomplice == "":
    {culprit}
- else:
    {accomplice}
} was with Evelyn on the night of her death, drugging them with sleeping pills. {accomplice == "":
        Later,
    - else:
        {culprit} comes in later
} when Evelyn was drunk and almost falling asleep, they ask for the documents to Evelyn's estate to be rewritten to their name.
When Evelyn refuses, they take the troyphy and hits them, in order to scare her into listening, but that wasn't the case was it?
The blow was too hard and she died immediately. The sudden death and her unfinished will made it so that Victor was next in line for the estate, therefore kept his company afloat.
-> arrest

=== arrest ===
{culprit}, you're under arrest for the murder of Evelyn Blake. { accomplice != "": {accomplice}, you're under arrest as an accomplice.}
-> END