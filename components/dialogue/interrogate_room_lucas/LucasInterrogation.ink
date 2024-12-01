LIST actors = Lucas
VAR speaker = "Shade"
VAR mood = "normal"
VAR lucas_victor = false
VAR lucas_diary = false
VAR victor_marina = false

=== choices ===
+   [What's Evelyn Like?]
	-> option_1
+   [Called Police]
    -> option_2
+   [Evelyn's Phone]
    -> option_3
+   [Their Usual Spot]
    -> option_4
+   {lucas_victor} [Ask about Victor]
	-> option_5
+   {victor_marina} [Relationship with Marina]
	-> option_6
*   {option_1 || option_2 || option_3 || option_4 || option_5 || option_6} I guess that covers it...
	-> END

=== option_1 ===
~   speaker = "Shade"
This must be hard. Can you tell me what Evelyn was like?
~   speaker = "Lucas"
~   mood = "ponder"
Evelyn... she was... different, y'know? Like, kinda cryptic? Everything she did had this... meaning, or a puzzle behind it. She was so into those. Her lock screen? Password hidden in some riddle. Every gift? Like, you'd need a treasure map to find it.
~   speaker = "Shade"
Sounds like she loved puzzles.
~   mood = "weak_smile_1"
~   speaker = "Lucas"
Yeah... that's one way to put it. She kept you guessing. Always.
-> choices

=== option_2 ===
~   speaker = "Shade"
You said you called the police when you found her. How long did it take?
~   mood = "defensive_1"
~   speaker = "Lucas"
Uh... maybe like, ten minutes? Or so?
~   speaker = "Shade"
Ten minutes? Why the delay? #exclaim
~   mood = "defensive_2"
~   speaker = "Lucas"
I... I was a wreck, man! The love of my life... just lying there, cold and lifeless. You htink I could just ... dial the cops like that? It took everythin in me to even move.
~   speaker = "Shade"
The love of your life? #exclaim
~   lucas_diary = true
-> choices

=== option_3 ===
~   speaker = "Shade"
Did you check her phone or notice anything odd in the studio?
~   mood = "calm"
~   speaker = "Lucas"
No, man... I couldn't. I was just... frozen, y'know? The whole place looked... normal. Too normal,  even. Like she'd just been working late, waiting for Marina to show up.
~   speaker = "Shade"
Nothing at all seemed out of place?
~   mood = "ponder"
~   speaker = "Lucas"
Well... okay, there was one thing. Victor.
~   speaker = "Shade"
Victor? Her brother? #exclaim
~   mood = "calm"
~   speaker = "Lucas"
Yeah. He was around a lot recently. He and Evelyn were always arguing about something--her art, the company, or the damn will. I know they'd fought a couple of days before. She was stressed out, and Victor didn't care. He just kept pushing her.
~   speaker = "Shade"
What do you think he wanted?
~   mood = "ponder"
~   speaker = "Lucas"
Control, maybe? That's his thing, y'know? Getting what he wants, no matter who gets hurt. But I didn't see him there when I found her. It's just... something doesn't sit right.
~   speaker = "Shade"
What about her phone?
~   mood = "defensive_1"
~   speaker = "Lucas"
I didn't... I just... couldn't.
~   lucas_victor = true
-> choices

=== option_4 ===
~   speaker = "Shade"
You mentioned meeting at your usual spot. Can you tell me about it?
~   mood = "defensive_1"
~   speaker = "Lucas"
Yeah... it's this little café we'd go to. Kinda like... our place. First dates, tough days, everything. That's where we'd always go.
~   speaker = "Shade"
What happened when you showed up?
~   mood = "defensive_2"
~   speaker = "Lucas"
I... I brought flowers. But when I got to her studio, something felt... wrong. She wasn't there. And then... I found her.
-> choices

=== option_5 ===
~   speaker = "Shade"
Did you see Victor around the time of Evelyn's death?
~   mood = "ponder"
~   speaker = "Lucas"
No. But he was around a lot lately. Always in her ear about the company. She didn't like it--he pushed her too much. They fought a couple days before... about her art. And her will.
~   speaker = "Shade"
Do you thing Victor was involved?
~   mood = "calm"
~   speaker = "Lucas"
I don't know... Maybe. He's the type to get what he wants, no matter who he steps on. But... I don't know for sure.
-> choices

=== option_6 ===
~   speaker = "Shade"
How was your relationship with Marina? You mentioned her being at the studio.
~   mood = "normal"
~   speaker = "Lucas"
Marina... she was... complicated. Always pushing Evelyn. 'Do more! Make money!' Like, she cared more about the business than Evelyn's happiness.
~   speaker = "Shade"
So, you don't trust her?
~   speaker = "Lucas"
I did... but not really. She cared about Evelyn's career, sure. But Evelyn? The person? Not so much.
~   speaker = "Shade"
Do you know where Marina lives?
~   speaker = "Lucas"
No idea. We weren't exactly close after Evelyn and I broke up. And no one knew we got back together either.
-> choices
