-> start
VAR speaker = "Narrator"

=== start ===
Officer: Lucas, you have a visitor. He's called Shade.
Shade: I'm here to help you, Lucas. I want to find the real culprit, but I'll need your cooperation.
Lucas: Help me? There's no point, is there? I'm the culprit... I have to be! Just give me the death sentence and end it already...
Shade: I don't believe you did it, Lucas. There's more to this story. Help me understand--tell me what really happened.
Lucas: Fine. You want the truth? I... I wanted to see her that night. But as  Igot to the door, she texted me--said Marina was coming over and to meet her at our usual spot tomorrow. So, I left. The next day, I came back with flowers... and that's when I found her.
Lucas: I called the cops... and they just threw me in here.
-> choices

=== choices ===
~   speaker = "Shade"
*   This must be hard. Can you tell me what Evelyn was like?
    -> option_1
*   {option_1} You said you called the police when you found her. How long did it take?
    -> option_2
*   {option_1} Did you check her phone or notice anything odd in the studio?
    -> option_3
*   {option_1} You mentioned meeting at your usual spot. Can you tell me about it?
    -> option_4
*   {option_2} Did you see Victor around the time of Evelyn's death?
    -> option_5
*   {option_1} How was your relationship with Marina? You mentioned her being at the studio.
    -> option_6
*   I guess that covers it...
    -> END

=== option_1 ===
Lucas: Evelyn... she was... different, y'know? Like, kinda cryptic? Everything she did had this... meaning, or a puzzle behind it. She was so into those. Her lock screen? Password hidden in some riddle. Every gift? Like, you'd need a treasure map to find it.
Shade: Sounds like she loved puzzles.
Lucas: Yeah... that's one way to put it. She kept you guessing. Always.
-> choices

=== option_2 ===
Lucas: Uh... maybe like, ten minutes? Or so?
Shade: Ten minutes? Why the delay?
Lucas: I... I was a wreck, man! The love of my life... just lying there, cold and lifeless. You htink I could just ... dial the cops like that? It took everythin in me to even move.
Shade: The love of your life?
*   [don't show diary]
	-> choices
*   [show diary]
    Lucas: What... what is this? Is that how she really felt? If that's true, why did she even bother getting back with me?!
    Shade: Maybe she changed her mind, Lucas. People grow, and maybe she saw something in you. You have changed, haven't you?
    Lucas: Yeah... yeah, maybe. We were starting fresh. What we had... it was real. I swear it was real.
    -> choices

=== option_3 ===
Lucas: No, man... I couldn't. I was just... frozen, y'know? The whole place looked... normal. Too normal,  even. Like she'd just been working late, waiting for Marina to show up.
Shade: Nothing at all seemed out of place?
Lucas: Well... okay, there was one thing. Victor.
Shade: Victor? Her brother?
Lucas: Yeah. He was around a lot recently. He and Evelyn were always arguing about something--her art, the company, or the damn will. I know they'd fought a couple of days before. She was stressed out, and Victor didn't care. He just kept pushing her.
Shade: What do you think he wanted?
Lucas: Control, maybe? That's his thing, y'know? Getting what he wants, no matter who gets hurt. But I didn't see him there when I found her. It's just... something doesn't sit right.
Shade: What about her phone?
Lucas: I didn't... I just... couldn't.
-> choices

=== option_4 ===
Lucas: Yeah... it's this little café we'd go to. Kinda like... our place. First dates, tough days, everything. That's where we'd always go.
Shade: What happened when you showed up?
Lucas: I... I brought flowers. But when I got to her studio, something felt... wrong. She wasn't there. And then... I found her.
-> choices

=== option_5 ===
Lucas: No. But he was around a lot lately. Always in her ear about the company. She didn't like it--he pushed her too much. They fought a couple days before... about her art. And her will.
Shade: Do you thing Victor was involved?
Lucas: I don't know... Maybe. He's the type to get what he wants, no matter who he steps on. But... I don't know for sure.
Shade: Where can I find him?
Lucas: His office. Here--take the address.
-> choices

=== option_6 ===
Lucas: Marina... she was... complicated. Always pushing Evelyn. 'Do more! Make money!' Like, she cared more about the business than Evelyn's happiness.
Shade: So, you don't trust her?
Lucas: I did... but not really. She cared about Evelyn's career, sure. But Evelyn? The person? Not so much.
Shade: Do you know where Marina lives?
Lucas: No idea. We weren't exactly close after Evelyn and I broke up. And no one knew we got back together either.
-> choices
