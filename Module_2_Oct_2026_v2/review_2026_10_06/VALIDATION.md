## Trainer R boxes improved, 6 October 2026

All eight visible trainer calculations now include short plain-language comments explaining their comparison, units and output. Shared styles use 22px code, clear comments, a framed editor and a "Trainer calculation - R" header. The duplicate echoed source underneath is hidden; results remain visible. The lottery demonstration now uses the full slide width. Participant coding and session durations are unchanged.

`review_2026_10_06/trainer_code.py` annotates visible cells in all four deck builders, preserving hidden setup code. All twelve generated QMDs, including the Day 4 alias, reproduced exactly in an isolated build; the final Day 1 layout was rechecked. `verify_trainer_boxes.py` ran all eight calculations and checked comments, header, font, duplicate echo, slide overflow and editor clipping. All passed: editor overflow zero, browser errors empty; results -669 / -812 / -721 / -1029 / 1.86 / 49.5 and pilot interval 862 to 1167 unchanged. Every calculation screenshot inspected. Hub verification: 49 local links, 53 byte-checked copies, phone and desktop layouts passed. Current downloads regenerated. Pre-change sources retained in backups/trainer_code_2026_10_06/.

The preceding Day 1 order and notice changes were published at 09d6559; Cloudflare and GitHub Pages deployment checks succeeded. This update continues the same authorised live publication route.

## Day 1 order and case notice corrected, 6 October 2026

Lucas requested the first two Day 1 sessions exchange places and explicitly teach the five core terms before regression-table reading. Session 1 is now **Read a regression table**: mean, treatment effect, coefficient, confidence interval and p-value; a two-row actual regression distinguishes the starting mean (1,432 AED) from the observed change (-669 AED). The fifth term recovered from the original lesson is treatment effect. A coefficient is not automatically a programme effect. Preserve ten minutes for independent reading, paired checking and feedback. Session 2 is **Question a claim**, applying the vocabulary to Fiona's four claim cards. Both remain 60 minutes; Day 1 S3 stays 75. Session 1/2 each have 11 content screens, two participant pages and four trainer pages. The classroom brief and hub match the order. The optional triage poster retains its legacy Oct12_session1 filename but is used in Session 2.

Generic fictional-case stamps are removed from slide content, plots and tables. Shared title-slide notice reads "GreenWaste is a fictional training case." exactly once per deck, 19px Noto Sans, regular grey; paper notices use Arial 9 grey. The four-page deliberately flawed report states its status on its first page. Keep substantive fictional-assumption and teaching-record labels where needed for interpretation.

Both revised decks were walked with feedback open: no browser errors or overflow, trainer Run reproduced -669, keyboard choices/reveals passed. All eleven title notices have identical computed styles and fit. Updated print pages and all nine classroom-brief pages rendered in Word and visually inspected. Three download archives regenerated with byte checks; all remain under 25 MiB. Existing backups in backups/case_notice_2026_10_06/ retain pre-change sources and materials. The latest source replaces the earlier Day 1 lesson; historical notes below are superseded.

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

## Day 2 approved rebuild and Day 1 data refresh

- Generator correction: exactly eight city rows at displayed score 58 changed; only took_part, cost_after and landfill_after. Pilot identical. Every city participation flag now follows score <= 58.
- Shared RDD model uses estimatr robust HC2; coefficient agrees with the browser lm, robust interval shared on screen and paper. Matching source and browser estimates agree.
- All six decks walked sequentially with live outputs, evidence opened and fragments visible.
- Oct12_session1_live: 12 slides including title; maximum lower overflow -16 px; browser errors [].
- Oct12_session2: 12 slides including title; maximum lower overflow -30 px; browser errors [].
- Oct12_session3_live: 14 slides including title; maximum lower overflow -21 px; browser errors [].
- Oct13_session1: 11 slides including title; maximum lower overflow -14 px; browser errors [].
- Oct13_session2_live: 11 slides including title; maximum lower overflow -35 px; browser errors [].
- Oct13_session3: 14 slides including title; maximum lower overflow -64 px; browser errors [].
- Word fallback rendered all Day 2 pages: participant 2/2/2, trainer 3/12/12. Refreshed Day 1 participant 2/2/2 and trainer 4/3/3. Partner brief 14 landscape pages. Every page visually inspected; no clipping. RDD A1 retained and visually checked.
- Final native controls checked keyboard reveal/toggle and choice without advancing slides, and three-column result tables. Room poll regression passed with two browsers and 320/375/1280 widths.
- Backups in backups/day2_2026_10_06_approved; local QA remains ignored. Main previews only, no live teaching-page change. Venue phone reachability remains a rehearsal check.

- Optional case reference refreshed from an older 6,000-city-business save to the current 10,000 records and computed means. Two A4 pages rendered and inspected at 12 point; technical before/after column names wrap explicitly.


## Day 3 approved rebuild

- Shared `day3_case.R`: ratio 1.86 under explicitly fictional assumptions, scenario ratios 1.07/1.40/1.67/1.17/0.80, percentages 49.5/58.6. Corrected DiD input and its causal limitation retained. No fabricated fieldwork or pre-trend checks.
- Sequential browser walks: S1 12 slides including title, lower overflow maximum -2 px; S2 11 slides, maximum -3 px; S3 14 slides, maximum -49 px. All browser errors []. Live outputs 1.86, 49.5, 862/1167 match shared objects. Scenario-table and percentage-output overflow fixed before passing walks.
- Final targeted QA after a shorter heading and enlarged chart labels: no logo overlap; all SVG labels inside viewBox; both axis states inspected with identical values. Native keyboard reveal/close and choices passed on all three decks; existing Day 1 opening and Day 2 RDD controls also checked.
- Word fallback: participant pages 2/2/2, trainer pages 9/3/5, shortened QA reference 1, partner brief 11 landscape pages. Every page visually inspected; revised cards and brief re-rendered after corrections. Ratio A1 landscape page rendered and inspected.
- Room poll HTTP/two-browser regression: anonymous replacement votes, hidden totals, Before/After counts, unauthorized and cross-origin rejection, closed/stale rejection, text-safe reasons, QR and widths 320/375/1280 all passed. Venue reachability remains untested.
- Scoped Day 3 generation and full-script syntax passed. Full legacy generator was not run, because Day 4 packs remain historical pending daily approval.
- Backup and QA artifacts remain ignored. Main publication contains unlinked previews only; live teaching pages stay unchanged. Day 4 tables are a proposal for the remaining two sessions.

- Preview copy hashes matched for all 18 files; Day 3 hub has 18 valid relative links, Day 4 plan 2. Source push 2019e52 and main preview push 7120980 succeeded. Unauthenticated URLs returned 403; online content was not inspected.


## Day 4 and complete-week checkpoint

- Approved Day 4 route: 11/9 content screens, 60/60 minutes. Native browser controls, no participant coding or new model lab. All 22 slides including titles walked sequentially with feedback open. Maximum lower overflow -52/-79 px, right overflow 0, no logo collision, browser errors []. Final keyboard choice/reveal/close checks passed (three S1 reveals, one S2 reveal).
- Independent five-ability reading assessment before AI/discussion, 0..2 each; provisional target 8/10 with no before/after or significance causal overclaim. Trainer keys accept defensible conditional actions and cited concerns, provide targeted retry and distinguish initial from revised score. No validated certification or transfer claim.
- Word fallback: report 4 pages, participant sheets 2/2, rating duplicate 2, trainer packs 7/3, corrected findings 1, optional template 1; exercise brief 9 landscape pages. Every final page rendered and inspected. Both A1 landscape sheets inspected after regeneration; labels, headers and grid fit.
- Screen and paper share day4_case.R, derived from corrected Day 1..3 objects. Planted report claims are distinguished from corrected writing evidence. Preferred city extra change 812, selected matching 1,029 with interval 859..1,200; pilot 1,014 interval 862..1,167; provisional model ratio 1.86 under fictional assumptions. No independent confirmation or real fieldwork assurance inferred from generated rows.
- Full default material generator ran successfully in isolated qa/week_generator/Module. Eleven trainer packs and eleven participant sheets; no Oct15 S3 output. No prior-day committed outputs rewritten during this verification.
- Room poll two-browser regression passed: replacement votes, totals hidden until close, Before/After [2,1], unauthorized/cross-origin 403, closed/stale 400, text-safe reasons, QR, configuration refresh and 320/375/1280 viewports. Venue LAN access remains untested.
- Combined downloads: 49 unique payload files plus a README in each archive, 11 decks, 11 participant sheets, 11 trainer packs, 4 poster PDFs/5 A1 sheets, references, classroom brief and room tool. Every zip entry matched its source hash; excluded slot absent. External webR runtime requires internet and venue rehearsal.
- Day 4 and whole-week hubs checked at 1280/375 widths; mobile table overflow repaired with a scroll container. Eighteen publication copies hash-verified; relative hub links resolve locally (Day 4 18, whole week 43, Day 3 18, Day 4 plan 3, historical week review 4).
- Unlinked previews only. Production teaching pages unchanged. No additional daily approval is pending.

The complete download was split into print materials and deck archives for Days 1-2 and Days 3-4 to respect Cloudflare's 25 MiB static asset limit. Each archive is size-checked before publication.

Published source checkpoints 63ff9cc/a92f8e8 and preview checkpoint 57df051; both pushes succeeded. Final downloads 762,846 / 17,193,159 / 13,686,934 bytes all below 25 MiB. Remote unauthenticated checks of both current review URLs returned 403; online content was not inspected. Worktrees have no remaining tracked changes apart from this checkpoint note. Unrelated untracked user files remain untouched.


## Working hub and live promotion

- Lucas explicitly requested landing-page work and publication of the whole week to the live site. Source and preview branches reconciled before promotion.
- New docs/index.html: DGE branding, day filters, eleven short session cards, current 60/75-minute timings, direct worksheets, three downloads and a keyboard-accessible trainer disclosure. No link to the old final workshop or stale PDF/PPTX exports. Final slot labelled as the other provider's simulation. Password gate unchanged; working hub carries noindex metadata.
- 53 copied live assets matched checked preview hashes, including corrected CSV beside live decks. Versioned pre-overwrite copies in backups/live_2026_10_06. Existing aliases redirect to current decks; former final-session URL shows a simulation notice.
- All 49 landing material links served HTTP 200 locally. Day filters, exclusive selection, keyboard activation, Day 4 hash/reload and trainer disclosure passed at 1280/768/375/320 widths. No horizontal overflow or browser errors; desktop, phone and expanded-trainer screenshots inspected.
- Live-root score-rule deck walked sequentially: 11 slides including title, Run output -721 from the corrected CSV, all feedback open, no overflow or browser errors. Other deck checks remain applicable via byte identity with their walked previews.
- All site assets fit the 25 MiB cap. Current preview review now links to the live working hub. Historical exports remain unlinked rather than advertised as current.

Live commit 0a0a03d pushed to main. Cloudflare Workers build and GitHub Pages build/deploy check runs all completed successfully. Main worktree validates 49 links, 11 live deck hashes and corrected CSV against previews. Remote requests returned 403; no authenticated browser available. Online page content therefore not inspected.
