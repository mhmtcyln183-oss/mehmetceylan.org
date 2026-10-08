# Local build report

Date: 8 October 2026  
Quarto: 1.10.19 (official portable Windows release; archive checksum verified)

## Result

The approved Round 4.1 “Margin” prototype has been converted into a working Quarto website project and rendered locally. No GitHub repository, GitHub Pages site, DNS record or live deployment was created or changed.

## Rendered pages

- English home page
- Turkish home page
- Spanish home page
- Simplified Chinese home page
- AEQ-PE-ES publication page

## Verification completed

- Successful clean Quarto render of all five pages
- Desktop and 390 px mobile visual review
- English and Simplified Chinese visual review; localized navigation labels checked for all four languages
- Internal file and anchor validation
- Exactly one visible `h1` per page
- Publication information order preserved: title/authors → quick journal/DOI/read → in brief → article details/actions → full content
- Five `hreflang` alternatives on each multilingual home page
- Social-card dimensions verified at 1200 × 630
- Approved portrait, three email addresses and verified Web of Science, ResearchGate and LinkedIn links added
- Visiting period confirmed as August 2026–April 2027; TÜBİTAK 2214-A acknowledgement confirmed
- Both “Use this measure” actions now link to Appendix 1 of their official CC BY 4.0 articles; the AEQ-PE-ES OSF project is accurately described as hosting data, the codebook and analysis outputs
- Pre-launch `noindex, nofollow` and blocking `robots.txt` verified
- No placeholder `href="#"`, CSS `display: contents`, or CSS `order` declarations
- axe-core 4.10.3 scan at WCAG 2.1 AA plus best-practice scope: zero reported violations on all five pages

axe-core left only manual-review items: it could not calculate the background of the white “iD” text inside the ORCID SVG, and it could not automatically infer heading order inside the custom Quarto template. The browser accessibility tree was reviewed manually; the visible heading hierarchy is correct.

## Still required before launch

See `PRODUCTION-CHECKLIST.md`. Multilingual terminology, the publication summary, final accessibility/link checks and final author approval remain unresolved. Indexing guards must remain in place until those items are approved.
