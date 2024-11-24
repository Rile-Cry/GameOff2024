VAR speaker = "Narrator"

-> start

=== start ===
Victor: Detective Shade, was it? I assume you have a reason for poking around my office?
Shade: Yes, Shade. Your office speaks volumes about you.
Victor: Success thends to leave an impression--though I suspect you're here for something more... pointed.
Victor: A detective from... where exactly? Must be quite the experience for you, stepping into a space like this. Now, what can I do for you?
Shade: I'm here to interrogate you on the murder of your sister, Evelyn Blake.
Victor: Detective, I've already spoken to the police. If you're here to waste my time, I suggest you think twice.
Shade: (I need to get him to talk)
-> choices

=== choices ===
~   speaker = "Shade"
*   [Bring up the Family Picture]
    -> option_1
*   [Ask About the Shredded Documents]
    -> option_2
*   [Estate Change]
    -> option_3
*   {option_3} [Pressure on the Estate Change]
    -> option_4
*   {option_4} [Push About the Estate and Marina]
    -> option_5
*   {option_5} [Marina's Location]
    -> option_6

=== option_1 ===
Shade: I noticed Evelyn isn't in your family photo. Oversight or intentional?
Victor: That photo was taken during... a difficult time. Families, Detective, are rarely as picturesque as we like to imagine. Surely you've seen worse in your line of work.
Shade: You had issues with her, didn't you? Enough to pressure her into changing her will?
Victor: I had my disagreements with Evelyn, yes. But family disagreements are hardly a crime, are they? Someone had to ensure the business survived her... whims.
-> choices

=== option_2 ===
Shade: These have some interesting mentions--yours sister's estate, Marina's name. Care to explain?
Victor: Detective, I'd suggest you tread carefully. Business dealings often involve sensitive matters, none of which concern you.
Shade: Sensitive? They paint a picture of control--control over Evelyn's estate and Marina. Convenient timing, wouldn't you say?
Victor: I make decisions based on what's best for the company. Evelyn's estate was a crucial asset, and Marina was invovled as her business partner. Hardly the conspiracy you seem so desperate to find.
-> choices

=== option_3 ===
Shade: Evelyn initially planned to leave her estate to charity. Why the sudden change?
Victor: Charity is a noble idea, but fleeting. I helped her see the bigger picture--legacy, Detective. Her art deserved a place in history, not to be scattered across causes that would forget her name in a year.
-> choices

=== option_4 ===
Shade: The timing of the will's change is suspicious, Victor. Right before her death, and suddenly everything goes to you. Doesn't that seem convinient?
Victor: Convenient? Hardly. It was practical. Evelyn wanted her work preserved, and I was the only one capable of ensuring that. Her decision, Detective--not mine.
Shade: And yet, you didn't waste time taking control after her death.
Victor: Efficiency isn't a crime, Detective. It's a necessity. Someone had to step in and handle the chaos.
-> choices

=== option_5 ===
Shade: You and Marina were closely involved in handling Evelyn's estate. her name comes up far too often for it to be a coincidence. What was her role in all of this?
Victor: Marina was... persistent. She believed in Evelyn's potential as much as I did, but our approaches differed. She was always pushing Evelyn for more. Sometimes it seemed her focus was more on profit than the art itself.
Shade: And you didn't find that troubling?
Victor: Troubling? I'd call it opportunistic. But in business, Detective, opportunism is an asset. We were aligned in preserving Evelyn's legacy, if not always in our methods.
-> choices

=== option_6 ===
Shade: Where can I find Marina? I need to speak to her.
Victor: Marina is a busy woman, Detective. She moves between her office and her apartment. I'm sure she'll find your questions just as... fascinating as I do.
Shade: I'll need something more concrete, Victor. You've been in frequent contact with her--you must know where she is.
Victor: Fine. Her apartment. But I'd advise you not to waster her time. She has a sharp tongue, Detective, and little patience for baseless accusations.
Victor: And now, I think we're done here. I've been more than generous with my time.
-> END