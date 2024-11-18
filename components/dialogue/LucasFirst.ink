-> start

VAR mood = false

=== start ===
Officer: Lucas, you have a visitor. He's called Shade.
Shade: I'm going to try and help you get away free catching the actual culprit, but for that I will need your help.
Lucas: I'm gonna be caught aren't I? I'm the culprit, just give me the death sentence, please...
Shade: I don't believe you're the culprit, Lucas. There's more to this than you're letting on. Why don't you tell me what really happened?
Lucas: I wanted to meet her that night, but as I got to the door a text from Evelyn pops up saying she has Marina coming over and asked me to meet her at our usual spot the next day. So I left only to return the next day with a bouquet of flowers, then I find her dead... I called the police and then they threw me in here.
-> choices

=== choices ===
*   You said you called the police when you found her. How long did it take you to contact them after finding her body?
    -> option_1
*   Did you check her phone or anything around the studio when you found her? Any signs of a struggle or someone else being there?
    -> option_2
*   You mentioned Evelyn asked you to meet her at the usual spot the next day. Can you tell me more about that spot?
    -> option_3
*   {option_2} Did you see Victor at all around the time of Evelyn's death?
    -> option_4
*   How was your relationship with Marina? You mentioned her coming over to the studio the night Evelyn died.
    -> option_5
*   I guess that covers it...
    -> END
    

=== option_1 ===
Lucas: It took me around 10 minutes after finding the body to contact the police.
Shade: 10 minutes? Why's that?
Lucas: I was overwhelmed at the sight of the love of my life's cold body. It took me a while to stop crying and get myself together.
Shade: Love of your life?
~   mood = true
*   [don't show diary]
    -> choices
*   [show diary]
    Lucas: What man, is that how she thought of me??! If that's the case, why did she even bother trying to date me again now?
    Shade: Maybe she feels differently about you now, you've changed right? If she didn't like you why would she even consider dating you?
    (this outta calm him down)
    Lucas: Yeah, man... we were starting fresh. I swear, what we had... it was real. It was always real.
    -> choices

=== option_2 ===
Lucas: No, man... everything seemed like it always was. The studio was clean, no signs of a struggle. It felt... normal, y'know? Evelyn was probably working late considering Marina was gonna come, so nothing about that felt off. As for the phone, I didn't check it.
Shade: Victor Blake? Her brother?
Lucas: Yeah, him. He always acted like the know-it-all genius with the money, the fame, everything anyone could want. You'd think he'd be supportive of Evelyn, right? But then there was all this stuff about her will... He started arguing about it.
Shade: Victor...
-> choices

=== option_3 ===
Lucas: Yeah, it's this little café we always went to when things got tough. It's where we started dating, you know? It's kinda our place y'know...
Shade: And what happened when you showed up the next day?
Lucas: I just... stood there. I brought her flowers, but when I got to her studio, everything felt wrong. She wasn't there. That's when I found her...
-> choices

=== option_4 ===
Lucas: No, but I know he's been around a lot lately. He and Evelyn were in contact about the company. She didn't like the pressure he put on her, but she did it because she wanted to make sure the family business would star afloat. I heard them arguing a couple of days before... about her art, about her will...
Shade: Do you know where I can find him?
Lucas: I'll give you and address to his office.
-> choices

=== option_5 ===
Lucas: Marina? She... she was always around. Always pushing Evelyn to do more. I couldn't understand it. I mean, I get that she wanted Evelyn to succeed, but sometimes it felt like she just wanted to use her for the money. And, you know, Evelyn... she just wanted to create. It wasn't about the money for her.
Shade: So you didn't trust Marina?
Lucas: I did, but no really. She pushed Evelyn too hard, made everything about business. She didn't care if it made Evelyn unhappy, as long as she got what she wanted.
Shade: Where can I find Marina? Do you know where she lives?
Lucas: No, not really. I didn't speak with her much after my breakup. No one knows about me and Evelyn getting back to be honest.
-> choices