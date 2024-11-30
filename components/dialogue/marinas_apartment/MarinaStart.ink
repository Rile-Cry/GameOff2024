LIST actors = Marina
VAR speaker = "Shade"
VAR mood = "defensive_2"
VAR photo_scene = "Case/Photos/Marina’s Apartment.tres"
VAR marina_photo = false

~   mood = "defensive_2"
~   speaker = "Marina"
Who the hell are you?! #shake_aggressive
~   speaker = "Shade"
Detective Shade. I’m investigating Evelyn Blake’s murder.
~   mood = "sigh"
~   speaker = "Marina"
Detectives, always so good at breaking and entering. Did the academy teach you to ignore doorbells, or is this a personal flair?
~   speaker = "Shade"
The door was unlocked, and you didn’t respond. I was concerned.
~   speaker = "Marina"
~   mood = "sassy"
Concerned? Maybe start by locking the door on your way out next time. Now, make it quick. I don’t have time for your games.
~   speaker = "Shade"
Don't worry, I’m... just here to ask a few questions.
~   mood = "sigh"
~   speaker = "Marina"
Questions. Of course. Because digging up non-existent dirt on me and Victor is a productive use of your time.
~   speaker = "Shade"
You mentioned Victor— #exclaim
~   mood = "defensive_2"
~   speaker = "Marina"
Yes, Victor. We’re both trying to keep it together after Evelyn’s death, and you poking around isn’t helping. So, what is it this time? #shake
-> choices


=== choices ===
~   speaker = "Shade"
+   [Relation with Evelyn]
	-> option_1
+   [Business Ventures]
	-> option_2
*   [Request for Photo]
	-> option_3

=== option_1 ===
~   mood = "normal"
Tell me about your relationship with Evelyn. You two worked closely together, didn’t you?
~   speaker = "Marina"
~   mood = "sigh"
We were business partners. She handled the art, I handled the logistics. It was a good balance. Not that it mattered in the end.
-> choices

=== option_2 ===
~   mood = "normal"
What kind of business ventures were you and Evelyn planning?
~   mood = "sassy"
~   speaker = "Marina"
Plenty. Evelyn was talented, and I made sure the world saw it. That’s what partners do. But now you’re here, turning all that into a spectacle.
-> choices

=== option_3 ===
Your apartment is striking. Mind if I take a quick photo for reference?
~   mood = "guarded"
~   speaker = "Marina"
Oh yeah? And why should I humor you?
~   speaker = "Shade"
* [Convince with Professionalism]
    This isn’t about invading your privacy, Marina. Sometimes photos help me see details I might miss in the moment. It’s purely for the investigation.
    ~   mood = "sigh"
    ~   speaker = "Marina"
    ~   marina_photo = true
    You’re persistent, I’ll give you that. Fine. But don’t touch anything—or I’ll have you arrested for real.#Photo#{photo_scene}
    -> END
* [Appeal to Her Ego]
    You’ve done an incredible job with this place. It shows you’ve got an eye for detail
    Evelyn must’ve seen that too. A quick photo could help me piece things together.
    ~   mood = "smirk"
    ~   speaker = "Marina"
    ~   marina_photo = true
    Hmph, fine. You get one shot Detective, but flattery can only get you so far.#Photo#{photo_scene}
    -> END
* [Push Back Against Her Defensiveness]
    Marina, if you have nothing to hide, then a photo shouldn’t be an issue. Or are you worried about what it might reveal? #exclaim
    ~   mood = "defensive_1"
    ~   speaker = "Marina"
    ~   marina_photo = true
    You’re unbelievable. Fine. But take your damn photo and leave. #shake#Photo#{photo_scene}
    -> END
* [Drop the Request]
    You’re right. I don’t want to intrude further. I’ll respect your space.
    ~   mood = "soft_guarded"
    ~   speaker = "Marina"
    Good. Now respect my time too, Detective, and get out.
    -> END