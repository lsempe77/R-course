# Course room voting

This replaces the Day 1 Menti activity with a course-owned facilitator page and
phone page. It has anonymous choices and reasons, Before and After phases,
hidden totals while voting is open, and a join QR code. It requires no external
account or paid service. Votes are kept in memory and disappear on shutdown.

## Rehearse on this computer

From this folder, run `python room_poll.py`. Open the private facilitator address
printed in the terminal. Open `http://127.0.0.1:8766` in another browser to vote.
Keep the facilitator address private; its token authorises opening and closing
votes. The QR package is optional: `qrcode` supplies the QR; the join address
still works if it is unavailable.

## Use with classroom phones

Connect the trainer computer and phones to a network that permits devices to
reach one another. Find the trainer computer's IPv4 address with `ipconfig`.
For example, if it is `192.168.1.20`, run:

```powershell
python room_poll.py --host 0.0.0.0 --join-url http://192.168.1.20:8766
```

Use the actual classroom address. Permit the local server through the computer's
firewall if the venue allows it. Test the QR on two phones before delivery.
Guest Wi-Fi sometimes blocks communication between devices. If it does, use
labelled cards or a show of hands. This server is for a classroom network, not
an internet deployment. The published static preview cannot collect room votes.

## Facilitate the activity

1. Open **Before** while only the initial claim is visible. Each participant
   chooses an answer and writes a short reason without their name.
2. Close voting, then discuss totals and reasons. Keep evidence reveals hidden
   until participants have committed.
3. Reveal the new evidence and open **After**. Close it before comparing totals.
4. Ask which evidence changed a reason. Different numbers of votes in each phase
   are possible; a shift in room totals alone is not a learning assessment.

The same browser can change its vote; it counts once per phase. Clearing browser
storage or using another browser can create another vote, so these are anonymous
browser counts rather than verified participant counts. Reasons are visible only
to the facilitator after closing. Use the individual worksheet tasks to assess
reading. Reset between questions, then enter two to four choices. The server can
also serve the three rendered Day 1 decks and their fictional CSV at their usual
filenames. It exposes no directory listing or other workspace files.
