VAR speaker = "Narrator"

-> start

=== start ===
Marina: Who the hell are you?
Shade: Detective Shade. I'm investigating Evelyn Blake's murder.
Marina: Detectives, always so good at breaking and entering. Did the academy teach you to ignore doorbells, or is this a personal flair?
Shade: The door was unlocked, and you didn't respond. I was concerned.
Marina: Concerned? Maybe start by locking the door on your way out next time. Now, make it quick. I don't have time for your games.
Shade: I'm just here to ask a few questions.
Marina: Questions. Of course. Because digging up non-existant dirt on me and Victor is a productive use of your time.
Shade: You mentioned Victor--
Marina: Yes, Victor. We're both trying to keep it together after Evelyn's death, and you poking around isn't helping. So, what is it this time?
-> choices_a

=== choices_a ===
~   speaker = "Shade"
*   [Relation with Evelyn]
    -> option_a1
*   [Business Ventures]
    -> option_a2

=== option_a1 ===
Shade: Tell me about your relationship with Evelyn. You two worked closesly together, didn't you?
Marina: We were business partners. She handled the art, I handled the logistics. It was a good balance. Not that it mattered in the end.
    -> transition

=== option_a2 ===
Shade: What kind of buisness ventures were you and Evelyn planning?
Marina: Plenty. Evelyn was talented, and I made sure the world saw it. That's what partners do. But now you're here, turning all that into a spectacle.
    -> transition

=== transition ===
Marina: Enough. I'm not answering more of your prying questions. You're wasting my time and energy. Get to the point or get out.
Shade: Your apartment is striking. Mind if I take a quick photo for reference?
-> choices_b

=== choices_b ===
~   speaker = "Shade"
*   [Convince with Professionalism]
    -> option_b1
*   [Appeal to Her Ego]
    -> option_b2
*   [Push Back Against Her Defensiveness]
    -> option_b3
*   [Drop the Request]
    -> option_b4

=== option_b1 ===
Shade: This isn't about invading your privacy, Marina. Sometimes photos help me see details I might miss in the moment. It's purely for the investigation.
Marina: You're persistent, I'll give you that. Fine. But don't touch anything--or I'll have you arrested for real.
-> END

=== option_b2 ===
Shade: You've done an incredible job with this place. It shows you've got an eye for detail--Evelyn must've seen that too. A quick photo could help me piece things together.
Marina: Flattery gets you one shot, Detective. Don't push your luck.
-> END

=== option_b3 ===
Shade: Marina, if you have nothing to hide, then a photo shouldn't be an issue. Or are you worried about what it might reveal?
Marina: You're unbelievable. Fine. But take your damn photo and leave.
-> END

=== option_b4 ===
Shade: You're right. I don't want to intrude further. I'll respect your space.
Marina: Good. Now respect my time too, Detective, and get out.
-> END