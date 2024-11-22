VAR speaker = "Narrator"
VAR spoken_to_first = false

-> start

=== start ===
Shade: Let's not waste time. Evelyn Blake didn't die by accident. This was a carefully planned crime, and one of you orchestrated it. By the end of this, I'll expose who.
Victor: I'm here out of courtesy, Detective. I trust you'll wrap this up quickly.
Marina: Same here. If you're going to waste our time, at least try to be interesting.
Lucas: I didn't do anything! Why am I even here? Evelyn was my everything. I could never hurt her!
Shade: Everyone at this table had a motive. You all wanted something from Evelyn, but only two of you decided to take her life. Let's piece this together.
-> branches

=== branches ===
~   speaker = "Shade"
*   [Victor's financial motives]
    -> victor_branch
*   [Marina's suspicious behavior]
    -> marina_branch
*   [Lucas' alibi]
    -> lucas_branch
*   {victor_branch && marina_branch && lucas_branch}[Push further]
    -> push_further

=== victor_branch ===
{ not spoken_to_first:
    Shade: Victor, let's start with you.
~   spoken_to_first = true
}
Shade: Evelyn changed her will, leaving her estate to you instead of charity. That alone is suspicious, but add your shredded documents, and it's clear you had something to hide.
Victor: Evelyn's decision was her own. I simply helped her see the practicality of keeping her assets in the family. That's not a crime, is it?
Shade: But it wasn't practicality, was it? It was desperation. Your finanical transactions show deals that were dependant on you gaining control of Evelyn's art. She refused to sell out, so you made sure she wouldn't have a choice.
Victor: Detective, if you have proof of your accusations, I'd love to see it.
-> branches

=== marina_branch ===
{ not spoken_to_first:
    Shade: Marina, let's start with you.
~   spoken_to_first = true
}
Shade: Marina, Evelyn's phone was found in your locked compartment. Care to explain why?
Marina: She left it at my place during one of our meetings. I meant to return it, but then... well, you know what happened.
Shade: Strange, considering Evelyn texted Lucas the night of her death. Are you saying she somehow managed that without her phone?
Marina: Are you seriously suggesting I had something to do with her death? Victor and I were trying to protect her legacy, unlike some people.
-> branches

=== lucas_branch ===
{ not spoken_to_first:
    Shade: Lucas, let's start with you.
~   spoken_to_first = true
}
Shade: Lucas, your alibi was shaky at best. Witnesses saw you near the studio after midnight.
Lucas: I didn't kill her! I went back because I was worried about her. I saw the light on and thought something was wrong, but when I got there, she was already--
Shade: Dead? Or drugged and unconscious, waiting for Victor to finish the job?
Lucas: I don't know! I didn't stay long. I couldn't handle it!
-> branches

=== push_further ===
*   [Victor's shredded documents]
    -> victor_push
*   [Marina's receipts for wine and pills]
    -> marina_push
*   [Lucas' emotional reaction]
    -> lucas_push
*   {victor_push && marina_push && lucas_push}[Finish this]
    -> turnabout

=== victor_push ===
Shade: Victor, the shredded documents in your office mentioned Marina and Evelyn's estate. You two planned this together, didn't you?
Victor: Planning? No. Discussing logistics? Perhaps. Evelyn's art was the cornerstone of our efforts to save the company. That required coordination.
Shade: Coordination to kill her? Marina provided the pills, you provided the motive, and together you silenced Evelyn when she refused to comply.
Victor: Bold accusation. Got proof?
-> push_further

=== marina_push ===
Shade: Marina, the receipts for wine and sleeping pills point directly to you. You drugged Evelyn to make her vulnerable. Care to deny it?
Marina: You're twisting everything! I gave her pills because she couldn't sleep. The wine was for a celebration we'd planned. I didn't kill her!
Shade: But you knew what Victor planned. You helped him set her up and clean the scene afterwards.
Marina: Stop putting words in my mouth.
-> push_further

=== lucas_push ===
Shade: Lucas, your reaction tells me you're hiding something. What aren't you saying?
Lucas: I loved her! But I knew something was wrong. Victor kept pushing her, and Marina was always in her ear. I should've done more to protect her!
Shade: But you didn't. You were too afraid of what they'd do, weren't you?
-> push_further

=== turnabout ===
Shade: Here's how it happened. Marina drugged Evelyn under the guise of helping her relax. Victor showed up later to confront Evelyn about the will and the company's future. When she still refused, he killed her--using Marina's setup to stage the scene, and later they cleaned it out.
Marina: I didn't want her dead! Victor said it was just to scare her into compliance. He lied to me!
Victor: You were complicit, Marina. Don't play the victim now.
Shade: Enough! Victor Blake, you're under arrest for the murder of Evelyn Blake. Marina Thorne, you're under arrest as an accomplice.
-> end

=== end ===
Victor: You'll regret this, Shade.
Marina: I didn't mean for this to happen!
Lucas: Evelyn deserved better. Thank you for finding the truth.
-> END