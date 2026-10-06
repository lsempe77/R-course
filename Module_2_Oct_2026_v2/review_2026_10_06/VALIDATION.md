# Day 1 validation on 6 October 2026

The approved 60/60/75-minute rebuild has 11/11/13 content screens, excluding
titles. The three rendered decks were walked sequentially in Chromium at
1280 by 720. Both trainer cells ran; the before/after result was -670 AED and
the lottery demonstration produced different manager-age comparisons on two
draws. No browser errors, horizontal overflow or slide overflow were reported.
Maximum bottom overflows were -16, -30 and -21 pixels in slide coordinates.

Evidence reveals and the SVG interval were opened, correct and incorrect AI
selections were checked, table headings were checked for contrast, and a focused
choice button accepted Space without advancing the presentation. The final
SVG interval was visually inspected after correcting its hide/reveal handling.

The participant sheets are two A4 pages each. Trainer packs are 4/3/3 pages.
The packaged DOCX renderer was attempted and reported missing soffice.exe.
Installed Word exported the documents to PDF; PyMuPDF rendered page images.
Every print page was inspected, including the partner brief. Windows source
encoding errors were fixed in the R authoring source, followed by regeneration
and a fresh render. Participant copies contain no keys or print instructions.

The room poll was exercised through its real HTTP server using two browser
participants. Checks covered replacing a vote, hidden totals while open,
Before/After counts, rejected unauthorised control and foreign-origin writes,
closed and stale submissions, configuration changes, text-safe reasons and
QR generation. Layouts passed at 320, 375 and 1280 pixels. The venue network
has not been tested; the labelled-card fallback remains available.

R generator syntax was checked. The scoped Day 1 generator completed without
rewriting other days' output files. The full legacy generator was not run to
completion because later-day packs remain under their existing review. It now
skips the retired Day 1 code and former Day 4 Session 3. Later-day table defaults
are restored after the Day 1 generation step.

All 15 relative links in the Day 1 review page resolve in the prepared preview
folder. The room-tool download contains the server, HTML page and instructions.
The CSV, later-day decks, existing A1 boards and published teaching pages were
left unchanged. Day 2 slide tables are a proposal pending daily review.

Detailed screenshots, JSON checks, PDFs and recovery copies stay local and are
ignored by Git. Reproduce the browser checks with `verify_day1.py`,
`verify_reading_controls.py` and `verify_room_poll.py` in this folder.
